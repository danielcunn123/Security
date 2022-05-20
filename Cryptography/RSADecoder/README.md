<h1>RSA Cryptanalysis</h1>

[RSA-2048](https://en.wikipedia.org/wiki/RSA_numbers#RSA-2048) is built upon two 1024-bit (256 byte) [pseudorandomly](https://en.wikipedia.org/wiki/Pseudorandom_number_generator) generated [base-10](https://en.wikipedia.org/wiki/Decimal) prime numbers. Randomness and length of these prime numbers are the foundation of modern cryptography mechanisms withstanding decades of the most advanced cryptographers and mathematicians attempting to optimise and simplify the decryption process of this algorithm since first wide-spread use in the 1970s.

<h3>Q&A</h3>

This document outlines a particular flaw intended "by-design" within the Rivest-Shamir-Adleman algorithm from a System Engineering and [Security Researcher](https://www.ziprecruiter.com/Career/Security-Researcher/What-Is-How-to-Become) perspective, purely for educational purposes.

Q. Will the Rivest-Shamir-Adleman algorithm last much longer??

A. To be honest, I do not know why this algorithim is currently the "industry standard" intended to ensure the *confidentiality* and *integrity* of the data. **Two** - **Five** years this algorithim will be **thrown out**.

Q. Remain computationally unfeasible??

A. Feasible when used with bulk collection of encrypted data, perhaps captured traffic from international/inter-continental cables or Internet Service Providers.

Q. How do we know if this algorithim is broken??

A. Simple answer, we won't know until its much too late. If encryption/cryptographic mechnisims are broken, there is no clear way to know whether the adversary has successfully decrypted the ciphertext or not..

<h2>How</h2>

Too confusing?? Watch [this](https://youtu.be/-ShwJqAalOk) video by Nottingham University.

More info soon!!

For now, read the 2,819,478 individual 512bit prime numbers avaliable [here](./media/512bit-prime)