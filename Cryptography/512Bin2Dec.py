import threading

def binary_to_int(binary_str):
    """Convert a binary string to an integer."""
    return int(binary_str, 2)

def read_binary_numbers_from_file(filename):
    """Read binary numbers from a file and return them as a list of strings."""
    with open(filename, 'r') as f:
        numbers = f.readlines()
    return [num.strip() for num in numbers]

def write_to_file(filename, data):
    """Write data to a file."""
    with open(filename, 'a') as f:
        f.write(data + '\n')

def convert_and_write_decimals_chunk(binary_numbers, output_file):
    """Convert binary numbers to decimal and write them to file."""
    for binary in binary_numbers:
        decimal = binary_to_int(binary)
        write_to_file(output_file, str(decimal))

def convert_and_write_decimals_multithreaded(input_file, output_file, num_threads):
    """Read binary numbers from a file, convert them to decimal using multiple threads, and write to another file."""
    binary_numbers = read_binary_numbers_from_file(input_file)
    chunk_size = (len(binary_numbers) + num_threads - 1) // num_threads  # Calculate chunk size per thread
    
    threads = []
    for i in range(num_threads):
        start_idx = i * chunk_size
        end_idx = (i + 1) * chunk_size
        chunk = binary_numbers[start_idx:end_idx]
        
        thread = threading.Thread(target=convert_and_write_decimals_chunk, args=(chunk, output_file))
        thread.start()
        threads.append(thread)
    
    for thread in threads:
        thread.join()

# Input file containing binary numbers
input_file = 'binary_primes.txt'
# Output file for decimal representations
output_file = 'decimal_primes.txt'
# Number of threads to use
num_threads = 4

# Perform the conversion and write to the output file using multiple threads
convert_and_write_decimals_multithreaded(input_file, output_file, num_threads)