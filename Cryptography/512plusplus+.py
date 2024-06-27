import sympy
import threading

def read_numbers_from_file(filename):
    """Read numbers from a file and return them as a list of integers."""
    with open(filename, 'r') as f:
        numbers = f.readlines()
    return [int(num.strip()) for num in numbers]

def write_to_file(filename, data):
    """Write data to a file."""
    with open(filename, 'a') as f:
        f.write(data + '\n')

def increment_and_check_primes(numbers, increment, output_file, start_index, end_index):
    """Increment each number in the list until the next number is reached and check for primes."""
    for i in range(start_index, end_index):
        current = numbers[i]
        next_num = numbers[i + 1] if i + 1 < len(numbers) else float('inf')
        while current < next_num:
            if sympy.isprime(current):
                write_to_file(output_file, str(current))
            current += increment

def threaded_prime_check(numbers, increment, output_file, num_threads):
    """Split the work among multiple threads."""
    thread_list = []
    chunk_size = len(numbers) // num_threads
    
    for i in range(num_threads):
        start_index = i * chunk_size
        end_index = (i + 1) * chunk_size if i != num_threads - 1 else len(numbers)
        thread = threading.Thread(target=increment_and_check_primes, args=(numbers, increment, output_file, start_index, end_index))
        thread_list.append(thread)
        thread.start()
    
    for thread in thread_list:
        thread.join()

# Input file containing numbers
input_file = 'decimal_primes.txt'
# Output file for prime numbers
output_file = 'incremented_primes_decimal.txt'
# Amount to increment by
increment_amount = 12345678987654321
# Number of threads
num_threads = 4

# Read numbers from the input file
numbers = read_numbers_from_file(input_file)

# Perform the increment and prime check using multiple threads
threaded_prime_check(numbers, increment_amount, output_file, num_threads)