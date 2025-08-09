import '../models/queue_model.dart';

class QueueService {
  Queue queue = Queue(currentNumber: 1, lastNumber: 0);

  int takeNumber() {
    queue.lastNumber++;
    return queue.lastNumber;
  }

  void nextNumber() {
    if (queue.currentNumber < queue.lastNumber) {
      queue.currentNumber++;
    }
  }

  Queue getQueue() {
    return queue;
  }
}
