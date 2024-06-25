import threading

def int_to_binary_str(n):
    """Convert an integer to a binary string."""
    return bin(n)[2:]

def read_numbers_from_file(filename):
    """Read numbers from a file and return them as a list of integers."""
    with open(filename, 'r') as f:
        numbers = f.readlines()
    return [int(num.strip()) for num in numbers]

def write_to_file(filename, data):
    """Write data to a file."""
    with open(filename, 'a') as f:
        f.write(data + '\n')

def convert_and_write_binaries_chunk(prime_numbers, output_file):
    """Convert prime numbers to binary and write them to file."""
    for number in prime_numbers:
        binary = int_to_binary_str(number)
        write_to_file(output_file, binary)

def convert_and_write_binaries_multithreaded(input_file, output_file, num_threads):
    """Read prime numbers from a file, convert them to binary using multiple threads, and write to another file."""
    prime_numbers = read_numbers_from_file(input_file)
    chunk_size = (len(prime_numbers) + num_threads - 1) // num_threads  # Calculate chunk size per thread
    
    threads = []
    for i in range(num_threads):
        start_idx = i * chunk_size
        end_idx = (i + 1) * chunk_size
        chunk = prime_numbers[start_idx:end_idx]
        
        thread = threading.Thread(target=convert_and_write_binaries_chunk, args=(chunk, output_file))
        thread.start()
        threads.append(thread)
    
    for thread in threads:
        thread.join()

# Input file containing large prime numbers
input_file = 'primes.512'
# Output file for binary representations
output_file = 'binary_primes.txt'
# Number of threads to use
num_threads = 4

# Perform the conversion and write to the output file using multiple threads
convert_and_write_binaries_multithreaded(input_file, output_file, num_threads)

print(f"Conversion and writing completed using {num_threads} threads.")

