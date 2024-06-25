import random
import threading
import time

def is_prime(n, k=5):
    """Use the Miller-Rabin primality test to check if a number is prime."""
    if n == 2 or n == 3:
        return True
    if n <= 1 or n % 2 == 0:
        return False

    r, d = 0, n - 1
    while d % 2 == 0:
        r += 1
        d //= 2

    for _ in range(k):
        a = random.randint(2, n - 2)
        x = pow(a, d, n)
        if x == 1 or x == n - 1:
            continue
        for _ in range(r - 1):
            x = pow(x, 2, n)
            if x == n - 1:
                break
        else:
            return False
    return True

def generate_prime(bits):
    """Generate a prime number with the specified number of bits."""
    while True:
        num = random.getrandbits(bits)
        if num % 2 == 0:
            num += 1
        if is_prime(num):
            return num

def int_to_binary_str(n):
    """Convert an integer to a binary string."""
    return bin(n)[2:]

def write_to_file(filename, data):
    """Write data to a file."""
    with open(filename, 'a') as f:
        f.write(data + '\n')

def task(thread_num, delay):
    while True:
    # Generate the first prime number (p)
        p = generate_prime(512)
    # Generate the second prime number (q)
        q = generate_prime(512)

        p_binary = int_to_binary_str(p)
        q_binary = int_to_binary_str(q)

        write_to_file('decimal_primes.txt', str(q))
        write_to_file('decimal_primes.txt', str(p))

    # Write the binary numbers to a different file
        write_to_file('binary_primes.txt', q_binary)
        write_to_file('binary_primes.txt', p_binary)

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
