from Crypto.Util import number
import threading
import time

def task(thread_num, delay):
    while True:
# Generate the first prime number (p)
        p = number.getPrime(512)

# Generate the second prime number (q)
        q = number.getPrime(512)

        print(q)
        print(p)
    
threads = []

# Number of threads to create
num_threads = 4

# Create and start each thread
for i in range(num_threads):
    # Create a thread and pass the target function and its arguments
    thread = threading.Thread(target=task, args=(i, i+1))
    # Start the thread
    thread.start()
    # Add the thread to the list
    threads.append(thread)

# Wait for all threads to complete
for thread in threads:
    thread.join()
