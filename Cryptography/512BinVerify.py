import sympy
import threading

def read_binary_numbers_from_file(filename):
    """Read binary numbers from a file and return them as a list of strings."""
    with open(filename, 'r') as f:
        binary_numbers = f.readlines()
    return [num.strip() for num in binary_numbers]

def verify_prime_from_binary(binary_str):
    """Convert a binary string to a decimal number and check if it's prime."""
    decimal_number = int(binary_str, 2)
    return sympy.isprime(decimal_number)

def verify_primes_chunk(binary_numbers, output_file):
    """Verify if binary numbers in the chunk are prime and write them to file."""
    for binary_num in binary_numbers:
        if verify_prime_from_binary(binary_num):
            write_to_file(output_file, binary_num)

def verify_primes_multithreaded(input_file, output_file, num_threads):
    """Read binary numbers from a file, verify primes using multiple threads, and write to another file."""
    binary_numbers = read_binary_numbers_from_file(input_file)
    chunk_size = (len(binary_numbers) + num_threads - 1) // num_threads  # Calculate chunk size per thread
    
    threads = []
    for i in range(num_threads):
        start_idx = i * chunk_size
        end_idx = (i + 1) * chunk_size
        chunk = binary_numbers[start_idx:end_idx]
        
        thread = threading.Thread(target=verify_primes_chunk, args=(chunk, output_file))
        thread.start()
        threads.append(thread)
    
    for thread in threads:
        thread.join()

def write_to_file(filename, data):
    """Write data to a file."""
    with open(filename, 'a') as f:
        f.write(data + '\n')

# Input file containing binary numbers
input_file = 'binary_numbers.txt'
# Output file for verified prime binary numbers
output_file = 'verified_primes_binary.txt'
# Number of threads to use
num_threads = 4

# Perform the verification and write to the output file using multiple threads
verify_primes_multithreaded(input_file, output_file, num_threads)