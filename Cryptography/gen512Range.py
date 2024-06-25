import random
import sympy
import threading
import time

def generate_large_prime(bits):
    """Generate a random large prime number of specified bit size."""
    while True:
        candidate = random.getrandbits(bits)
        if sympy.isprime(candidate):
            return candidate

def find_primes_in_range(start, end):
    """Find all prime numbers within a given range."""
    primes = []
    candidate = sympy.nextprime(start - 1)
    while candidate < end:
        primes.append(candidate)
        candidate = sympy.nextprime(candidate)
    return primes

def find_primes_multithreaded(start, end, num_threads):
    """Find all prime numbers within a given range using multiple threads."""
    step = (end - start) // num_threads
    threads = []
    results = []
    
    def worker(thread_id, start, end):
        primes = find_primes_in_range(start, end)
        results.extend(primes)
    
    # Create threads
    for i in range(num_threads):
        thread_start = start + i * step
        thread_end = thread_start + step if i < num_threads - 1 else end
        thread = threading.Thread(target=worker, args=(i, thread_start, thread_end))
        threads.append(thread)
        thread.start()
    
    # Wait for all threads to complete
    for thread in threads:
        thread.join()
    
    return results

# Define the bit size and range for prime numbers
bits = 512
start = 10109040997585667746042395303674808345852235688506156456126221648762474105654492915316583776949126016431437331147559935538692888234038783829410058993272313
end = 10904190068128547673693763924553395814113470841354620439367030440211840353302892637973056979339249391261329584904857566346432096823730561158223727305046671

# Number of threads to use
num_threads = 4

# Find primes in range using multithreading
start_time = time.time()
large_primes = find_primes_multithreaded(start, end, num_threads)
end_time = time.time()

# Write primes to a file
output_file = '512bit_primes.txt'
with open(output_file, 'w') as f:
    for prime in large_primes:
        f.write(str(prime) + '\n')

print(f"Found {len(large_primes)} primes in the range using {num_threads} threads.")
print(f"Execution time: {end_time - start_time} seconds.")
