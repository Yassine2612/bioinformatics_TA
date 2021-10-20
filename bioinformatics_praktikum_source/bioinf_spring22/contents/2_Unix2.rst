Introduction to Unix 2
======================
General informations
^^^^^^^^^^^^^^^^^^^^
Main objective
--------------
In this lecture we will continue learning to use Unix-based systems. We will learn how to look at files and search them, how to control the flow of input and output to programs and responsible use of HPC clusters.

Learning objectives
-------------------
* Students can look at the contents of text files on the terminal
* Students can use grep to search within text files
* Students can use pipes to control input and output, and combine commands
* Students are familiarised with HPC queuing systems

 

Requirements
------------

* Computer/Laptop with access to the ETHZ network, via VPN if necessary

Searching for and within files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Looking at files
----------------

The command **cat** displays the entire contents of a file directly on the terminal. For large files this can be disastrous, so remember that you can cancel commands in progress with **ctrl + c**.

.. code-block:: bash

    # ConCATenate
    cat E.coli_K12_MG1655.fna

The command **head** displays only the first 10 lines of a file directly on the terminal. If you look at the available options for the command, *-n x* outputs the first *x* lines instead, and using a negative number outputs the lines except for the last *x*.

.. code-block:: bash

    # Show file head
    head E.coli_K12_MG1655.fna
    head -n 1 E.coli_K12_MG1655.fna

The command **tail** displays only the last 10 lines of a file directly on the terminal. It has similar options to *head*; *-n x* outputs the last *x* lines, and using a positive number *+x* (note the "+" character) outputs the lines except for the first *x*.

.. code-block:: bash

    # Show file tail
    tail E.coli_K12_MG1655.fna

The command **less** is a versatile way to look at a file in the command line. Instead of showing you the contents of a file directly on the terminal, it 'opens' the file to browse. You can use the arrow keys, page up, page down, home, end and the spacebar to navigate the file. Pressing *q* will quit. A number of useful options exist for the command, such as showing line numbers or displaying without line wrapping. It also has a search feature that we will cover later.

.. code-block:: bash

    # Browse file
    less E.coli_K12_MG1655.fna

The command **wc** is a command that will quickly count the number of lines, words and characters in a file, including invisible characters like 'newline' and whitespace. Its options allow you to specify which value to return, otherwise it gives all three.

.. code-block:: bash

    # Count things
    wc E.coli_K12_MG1655.fna

Exercises
---------

* Use **cat** to look at the *E. coli* genome file you copied last time, is it suitable for looking at this file?
* Use **head** and **tail** to examine the first and last 10 lines of the genome file. Now try to look at the first and last 20 lines.
* Use **less** to look at the genome file. Navigate through the file with the keys listed above, then return to the Terminal.
* Use the **man** command we learned to read about the **wc** command.
* Can you find out how many lines are in the genome file?

.. hidden-code-block:: bash

    # Look at the first 20 lines
    head -n 20 E.coli_K12_MG1655.fna

    # Look at the last 20 lines
    tail -n 20 E.coli_K12_MG1655.fna

    # Count the number of lines in the file
    wc -l E.coli_K12_MG1655.fna

Wildcards
---------

When providing a file path as an argument to a command, it is often possible to provide multiple file paths using *wildcards*. These are special characters or strings that can be substituted for a matching pattern.

* **?** matches any single character
* \* matches any number of any characters
* **[...]** matches any character within the brackets
* **{word1,word2,...}** matches any string inside the brackets

For instance:

.. code-block:: bash

    # Pattern matching
    ls /cluster/home/ssunagaw/teaching/ecoli/*      # lists all files in the ecoli directory
    ls /cluster/home/ssunagaw/teaching/ecoli/*.fna  # lists all nucleotide fasta files there
    ls /cluster/home/ssunagaw/teaching/ecoli/*.f?a  # lists all nucleotide and protein fasta files there

Searching for a file
--------------------

When you are trying to find a file in your system, the command **find** offers a number of options to help you. The first argument is where to start looking (it looks recursively inside all directories from there), and then an option must be given to specify the search criteria.

.. code-block:: bash

    # Finding files
    find . -name "*.txt"  # searches for files ending in .txt
    find . -mtime -2      # searches for files modified in the last two days
    find . -mtime +365    # searches for files modified at least one year ago
    find . -size +1G      # searches for files at least 1GB or larger
    find . -maxdepth 1    # searches only here, i.e.: doesn't look inside directories

Exercises
---------

* Use **ls** to get a list of all files in the /cluster/home/ssunagaw/teaching/ecoli directory
* Use **cp** to copy all files from the ecoli directory into a directory in your home directory
* Navigate to the /cluster/ssunagaw/teaching directory
* Use **find** to look for all .txt files there
* Use **find** to look for all files larger than 1MB
* Now combine these criteria to find all .txt files larger than 1MB

.. hidden-code-block:: bash

    # Make a directory for the new files
    cd ~
    mkdir ecoli

    # Copy all the files
    cp /cluster/home/ssunagaw/teaching/ecoli/* ~/ecoli/

    # Navigation
    cd /cluster/home/ssunagaw/teaching

    # Looking for files
    find . -name "*.txt"
    find . -size +1M
    find . -name "*.txt" -size +1M

Searching in **less**
---------------------

When you open a file to look at it using **less**, it is also possible to search within that file by pressing **/** (search forwards) or **?** (search backwards) followed by a pattern.

.. code-block:: bash

    # Finding strings
    /AAAAAAAAA  # finds the next instance of "AAAA"
    ?TTTTTTTTT  # finds the previous instance of "TTTT"

These same commands will also work with **man**, helping you to find a particular argument more easily.

But what happens when you search for "."? The entire document will be highlighted! Why is this?

Regular Expressions
-------------------

The reason this happens is that in the context of these search functions, "." represents *any character*. It is acting as a wildcard, from a different set of wildcards to those discussed above.

This set of wildcards is part of a system of defining a search pattern called **regular expression** or **regex**. Such a pattern can consist of wildcards, groups and quantifiers, and may involve some complex logic which we will not cover here. Further, the exact set of wildcards available depends on the programming language being used.

.. code-block:: bash

    # Wildcards and quantifiers
    .   any character
    \d  any digit
    \w  any letter or digit
    \s  any whitespace

    ^   the start of the string
    $   the end of the string

    *   pattern is seen 0 or more times
    +   pattern is seen 1 or more times
    ?   pattern is seen 0 or 1 times

These are just a few of the possibilities available. An example regular expression that would search for email addresses, for instance, would be:


    # name@domain.net can be matched as: \w+@\w+\.\w+
    echo "name@domain.net" | grep -E '\w+@\w+\.\w+'
    echo "name@domain.net" | grep -E '\w+@\w+'
    echo "name@domain.net" | grep -E '@\w+'

Grep
----

The command **grep** allows you to search within files without opening them first with another program. It also uses regular expressions to allow for powerful searches, and has a number of useful options to help give you the right output.

.. code-block:: bash

    # A simple **grep**
    grep "AAAAAAAAA" E.coli.fna        # shows all lines containing "AAAAAAAAA" highlighted

    # Using grep with a regex
    grep -E "(ACGT)(ACGT)+" E.coli.fna # shows all lines containing "ACGTACGT.." highlighted

    # Useful options
    grep -o  # show only the matches
    grep -c  # show only a count of the matches

Exercises
---------

* Navigate to the directory you copied the *E. coli* files to earlier.
* Use **less** to look at the GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna file, containing nucleotide gene sequences.
* Search within less to find the sequence for **dnaA**.
* Use **grep** to find the same entry in the file.
* Use **grep** to count how many fasta entries the file has. As a reminder, a FASTA header always starts with a '>'.
* Find out, which entry number the gene **dnaA** is?
* If you are interested in learning regular expressions, try the exercises `here <https://regexone.com/>`_

.. hidden-code-block:: bash

    # Navigation
    cd ~/ecoli

    # Look at the file
    less GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna

    # Type this within less:
    /dnaA

    # Type 'n' or 'N' after to see if there are more search hits

    # Use grep
    grep 'dnaA' GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna

    # Use grep to count
    grep -c '>' GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna

    # Which entry number?
    grep '>' GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna | grep -n 'dnaA'

Data wrangling
^^^^^^^^^^^^^^
A lot of time and effort in bioinformatics is spent arranging data in the correct way or correct format (aka "data wrangling"). Consequently, it is very useful to know how to filter and rearrange data files. In these exercises, we will learn some of the commands we use to do this.

The command **sort** will sort each line of a file, alphabetically by default, but other options are available.

.. code-block:: bash

    # Sort some example files
    cat /cluster/home/ssunagaw/teaching/session3/sort_words.txt
    sort /cluster/home/ssunagaw/teaching/session3/sort_words.txt

    cat /cluster/home/ssunagaw/teaching/session3/sort_nums.txt
    sort -n /cluster/home/ssunagaw/teaching/session3/sort_nums.txt

The command **cut** allows you to extract a single column of data from a file, for instance a .csv or .tsv file.

.. code-block:: bash

    # Look at some experimental metadata and extract the column we are interested in
    less /cluster/home/ssunagaw/teaching/session3/metadata.tsv
    cut -f 4 /cluster/home/ssunagaw/teaching/session3/metadata.tsv

The command **paste** allows you to put data from different files into columns of the same file.

.. code-block:: bash

    # Put together two files into one
    paste /cluster/home/ssunagaw/teaching/session3/sort_words.txt /cluster/home/ssunagaw/teaching/session3/sort_nums.txt

The command **tr** will replace a given character set with another character set, but to use it properly you need to know how to combine commands (below).

.. code-block:: bash

    # For instance, this command requires you to type the input in
    tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'

    # Then try typing AN UPPER CASE SENTENCE
    # Remember to exit a program that is running use ctrl + c

    # It can also be used to delete characters
    tr -d 'a'

    # Then try typing a sentence with the letter 'a' in it.
    # Remember to exit a program that is running use ctrl + c

The command **uniq** compresses adjacent repeated lines into one line, and is best used with sort when combining commands (see below).

.. code-block:: bash

    # Look at a file and remove adjacent repeated lines
    less /cluster/home/ssunagaw/teaching/session3/uniq_nums.txt
    uniq /cluster/home/ssunagaw/teaching/session3/uniq_nums.txt

    # Count how many times each value is repeated
    uniq -c /cluster/home/ssunagaw/teaching/session3/uniq_nums.txt

Exercises
---------

* Use the **sort** examples above and see what happens when you try to sort the *sort_nums.txt* file without the -n flag.
* Look at the file */cluster/home/ssunagaw/teaching/session3/sort_tab.txt*.
* Extract the second column of this file using **cut**.
* Looking at the manual for **sort**, can you figure out how to sort *sort_tab.txt* according to the second column, or 'key'?
* Use **paste** to combine the two files *sort_words.txt* and *sort_nums.txt* (in the directory */cluster/home/ssunagaw/teaching/session3/*) into a single two-column output.
* Use **tr** so that when you enter the word *banana* it comes out as *rococo*.
* Use the **uniq** examples above, then check with **uniq -c** that each line in *sort_tab.txt* is unique.

.. hidden-code-block:: bash

    # Look at sort_tab.txt
    less /cluster/home/ssunagaw/teaching/session3/sort_tab.txt

    # Extract the second column
    cut -f 2 /cluster/home/ssunagaw/teaching/session3/sort_tab.txt

    # Sort the table by second column
    sort -n -k 2 /cluster/home/ssunagaw/teaching/session3/sort_tab.txt
    # Note that if you forget the -n then the numbers are sorted alphabetically, not numerically

    # Use paste to combine files
    paste /cluster/home/ssunagaw/teaching/session3/sort_words.txt /cluster/home/ssunagaw/teaching/session3/sort_nums.txt

    # Use tr to convert one word into another
    tr 'ban' 'roc'
    # Then input banana and back comes rococo!

    # Check file with uniq
    uniq -c /cluster/home/ssunagaw/teaching/session3/sort_tab.txt
    # Each value in the first column is 1 - no repeats!

Combining commands
------------------

The power of this set of commands comes when you use them together, and when you can save your manipulated data into a file. To understand how to do this we have to think about the command line input and output data.

Input and output
----------------

So far we have been using files as arguments for the commands we have practiced. The computer looks at the memory where the file is stored and then passes it through RAM to the processor, where it can perform whatever you have asked it to. We have seen output on the terminal, but it's equally possible to store that output in memory, as a file. Similarly, if we want to use the output of one command as the input to a second command, we can bypass the step where we make an intermediate file.

The command line understands this in terms of **data streams**, which are communication channels you can direct to/from files or further commands:

.. code-block:: none

     stdin: the standard data input stream
    stdout: the standard data output stream (defaults to appearing on the terminal)
    stderr: the standard error stream (also defaults to the terminal)

Although you can usually give files as input to a program through an argument, you can also use *stdin*. Further, you can redirect the output of *stdout* and *stderr* to files of your choice.

.. code-block:: bash

    # Copy and rename the file containing the E.coli genome
    cd
    cp /cluster/home/ssunagaw/teaching/ecoli/GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna E.coli.fna
    cp /cluster/home/ssunagaw/teaching/ecoli/GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna E.coli_CDS.fna

    # Using the standard streams
    head < E.coli.fna                  # send the file to head via stdin using '<'
    head E.coli.fna > E.coli_head.fna  # send stdout to a new file using '>'
    head E.coli.fna 2> E.coli_err.fna  # send stderr to a new file using '2>'
    head E.coli.fna &> Ecoli_both.fna  # send both stdout and stderr to the same file using '&>'

Chaining programs together
--------------------------

Sometimes you want to take the output of one program and use it in another -- for instance, run *grep* on only the first 10 lines of a file from *head*. This is a procedure known as **piping** and requires you to put the **|** character in between commands (although this may not work with more complex programs).

.. code-block:: bash

    # Piping
    head E.coli.fna | grep "ACGT"                  # send the output of head to grep and search
    grep -A 1 ">" E.coli_CDS.fna | grep -c "^ATG"  # use grep to find the first line of sequence of each gene and send it to a second grep to see if the gene starts with ATG

Exercises
---------

* Copy the file *GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna* to your home and rename it to *E.coli_CDS.fna*
* Use **grep** to find all the fasta headers in this file, remember that a fasta header line starts with '>'.
* Send the output of this search to a new file called *cds_headers.txt*.
* Use **grep** again to find only the headers with gene name information, which looks like, for instance [gene=lacZ], and save the results in another new file called named_cds.txt.
* Use **wc** to count how many lines are in the file you made.
* Now repeat this exercise **without** making the intermediate files, instead using pipes.

As an additional challenge:

* Using the commands we have used, find the start codon of each gene in *E. coli* and then count up the frequency of the different start codons.

.. hidden-code-block:: bash

    # Copy the file to your home directory
    cp /cluster/home/ssunagaw/teaching/ecoli/GCF_000482265.1_EC_K12_MG1655_Broad_SNP_cds_from_genomic.fna ~/E.coli_CDS.fna

    # Find the fasta headers
    grep '^>' E.coli_CDS.fna

    # Send the output to a new file
    grep '^>' E.coli_CDS.fna  > cds_headers.txt

    # Find named genes
    grep '\[gene=' cds_headers.txt > named_cds.txt

    # Count how many there are
    wc -l named_cds.txt

    # Repeat without intermediate files
    grep '^>' E.coli_CDS.fna  | grep '\[gene=' | wc -l

    # Count the frequency of start codons in the *E.coli* genome
    grep -A 1 '^>' E.coli_CDS.fna | grep -Eo '^[ACGT]{3}' | sort | uniq -c | sort -nr -k 1
    # The first part finds all headers plus the first line of sequence
    # The second part is a regular expression to find the first three nucleotides in the sequence lines
    # Then we have to sort them so that we can count them with uniq
    # The final part is a bonus that sorts by descending frequency

    # And as so often in bioinformatics, there are several ways of getting a task done.
    # Consider the following alternative:
    grep -A 1 ">" E.coli_CDS.fna | grep -v '>' | grep -o "^\w\w\w" | sort | uniq -c | sort -k1nr


Homework
^^^^^^^^
Create a cheat sheet
--------------------

*could be homework* creat a cheat sheet and in the next lecture we provide one as solution. Could be also a part of the evaluation that they hand in a cheatsheet. This would also ensure that they go once again through the material.

Learning a new language and computational programming have many similarities with verbs, adverbs and objects equating to commands (action), options (modify action) and arguments (target of the option). As with learning languages, mastering programming requires practice and repetition. To take first steps, please visit the following page and create a "cheat sheet" for the relevant commands used today, so that this will serve you as a future reference. Defining the general purpose of a command, the most important options and showing examples with meaningful placeholders may be the most effective approach.
Create your cheat sheet here: https://docs.google.com/document/d/1xsH1yiW3B-rZsTIjF2T5NB_4NmaU_ZO3srcmT5_iHgc/edit

