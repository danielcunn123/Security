import sympy
import threading

def read_decimal_numbers_from_file(filename):
    """Read decimal numbers from a file and return them as a list of integers."""
    with open(filename, 'r') as f:
        numbers = f.readlines()
    return [int(num.strip()) for num in numbers]

def verify_prime(number):
    """Check if a number is prime."""
    return sympy.isprime(number)

def verify_primes_chunk(numbers, output_file):
    """Verify if numbers in the chunk are prime and write them to file."""
    for number in numbers:
        if verify_prime(number):
            write_to_file(output_file, str(number))

def verify_primes_multithreaded(input_file, output_file, num_threads):
    """Read decimal numbers from a file, verify primes using multiple threads, and write to another file."""
    decimal_numbers = read_decimal_numbers_from_file(input_file)
    chunk_size = (len(decimal_numbers) + num_threads - 1) // num_threads  # Calculate chunk size per thread
    
    threads = []
    for i in range(num_threads):
        start_idx = i * chunk_size
        end_idx = (i + 1) * chunk_size
        chunk = decimal_numbers[start_idx:end_idx]
        
        thread = threading.Thread(target=verify_primes_chunk, args=(chunk, output_file))
        thread.start()
        threads.append(thread)
    
    for thread in threads:
        thread.join()

def write_to_file(filename, data):
    """Write data to a file."""
    with open(filename, 'a') as f:
        f.write(data + '\n')

# Input file containing decimal numbers
input_file = 'decimal_numbers.txt'
# Output file for verified prime decimal numbers
output_file = 'verified_primes_decimal.txt'
# Number of threads to use
num_threads = 4

# Perform the verification and write to the output file using multiple threads
verify_primes_multithreaded(input_file, output_file, num_threads)