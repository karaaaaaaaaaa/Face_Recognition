import 'dart:math';
import 'dart:ui';
import 'package:Face_Recognition/HomeScreen.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'Recognition.dart';
import '../main.dart';
import 'package:tflite_flutter_plus/tflite_flutter_plus.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  late List<int> _inputShape;
  late List<int> _outputShape;

  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;

  late TfLiteType _inputType;
  late TfLiteType _outputType;

  late var _probabilityProcessor;

  @override
  
  String get modelName => 'facenet.tflite';

  @override
  //  it creates a new [TensorBuffer], which satisfies:
  /// Normalizes a [TensorBuffer] with given mean and stddev: output = (input - mean) / stddev.
  // output = (input - mean) / stddev
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);

// Constructs
  Recognizer({int? numThreads}) {
      /// Creates a new options instance.
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
  }
// Creates interpreter from model
  Future<void> loadModel() async {
    try {
      // The "interpreter" is an object used in TensorFlow Lite to execute the trained model for face recognition.
      // The interpreter handles the input image and performs the necessary computational operations
      // to predict the identity of the face in the image.
      // modelName==model.tflite
      interpreter =
      await Interpreter.fromAsset(modelName, options: _interpreterOptions);
      print('Interpreter Created Successfully');

  /// Gets the input Tensor for the provided input index.
      _inputShape = interpreter.getInputTensor(0).shape;
      // shap ==   /// Dimensions of the tensor.
      _outputShape = interpreter.getOutputTensor(0).shape;
      _inputType = interpreter.getInputTensor(0).type;
      _outputType = interpreter.getOutputTensor(0).type;
      
// Creates a [TensorBuffer] with specified [shape] and [TfLiteType]

      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
      _probabilityProcessor =
          TensorProcessorBuilder().add(postProcessNormalizeOp).build();
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  TensorImage _preProcess() {
    int cropSize = min(_inputImage.height, _inputImage.width);
    return ImageProcessorBuilder()
    // The ResizeWithCropOrPadOp is an operation used for resizing an image 
    //with cropping or padding to a specified size. 
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(
        _inputShape[1], _inputShape[2], ResizeMethod.nearestneighbour))
  /// Normalizes a [TensorBuffer] with given mean and stddev: output = (input - mean) / stddev.
  // output = (input - mean) / stddev
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage);
  }

  Recognition recognize(Image image,Rect location) {
    final pres = DateTime.now().millisecondsSinceEpoch;
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = _preProcess();
    // هنحسب وقت الرفع الصوره ووقت الاستحدام
    final pre = DateTime.now().millisecondsSinceEpoch - pres;
    print('Time to load image: $pre ms');
    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
    final run = DateTime.now().millisecondsSinceEpoch - runs;
    print('Time to run inference: $run ms');
    //
     _probabilityProcessor.process(_outputBuffer);
    //     .getMapWithFloatValue();
    // final pred = getTopProbability(labeledProb);
    print(_outputBuffer.getDoubleList());
    Pair pair = findNearest(_outputBuffer.getDoubleList());
    // add all information in Recognition Model
    return Recognition(pair.name,location, _outputBuffer.getDoubleList(),pair.distance);
  }

  //TODO  looks for the nearest embeeding in the dataset
  // and retrurns the pair <id, distance>
  findNearest(List<double> emb){
    Pair pair = Pair("Unknown", -5);
    for (MapEntry<String, Recognition> item in HomeScreen.registered.entries) {
      final String name = item.key;
      List<double> knownEmb = item.value.embeddings;
      double distance = 0;
      for (int i = 0; i < emb.length; i++) {
        double diff = emb[i] - knownEmb[i];
        distance += diff*diff;
      }
      distance = sqrt(distance);
      if (pair.distance == -5 || distance < pair.distance) {
        pair.distance = distance;
        pair.name = name;
      }
    }
    return pair;
  }

  void close() {
    interpreter.close();
  }

}
class Pair{
   String name;
   double distance;
   Pair(this.name,this.distance);
}


