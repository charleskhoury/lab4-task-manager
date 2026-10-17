import unittest
from io import StringIO
from todo import Task, TaskPool


class TestTaskPool(unittest.TestCase):
    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        task = Task("New Task")
        self.pool.add_task(task)
        self.assertEqual(len(self.pool.tasks), 1)

    def test_get_open_tasks(self):
        self.pool.populate()
        open_tasks = self.pool.get_open_tasks()
        for task in open_tasks:
            self.assertEqual(task.status, "ToDo")
        self.assertTrue(all(t in self.pool.tasks for t in open_tasks))

    def test_get_done_tasks(self):
        self.pool.populate()
        done_tasks = self.pool.get_done_tasks()
        for task in done_tasks:
            self.assertEqual(task.status, "Done")
        self.assertTrue(all(t in self.pool.tasks for t in done_tasks))


if __name__ == "__main__":
    suite = unittest.TestLoader().loadTestsFromTestCase(TestTaskPool)
    stream = StringIO()
    runner = unittest.TextTestRunner(stream=stream, verbosity=2)
    runner.run(suite)

    stream.seek(0)
    for line in stream.readlines():
        if " ... ok" in line:
            test_name = line.strip().split(" ")[0]
            print(f"{test_name} ... ok")
