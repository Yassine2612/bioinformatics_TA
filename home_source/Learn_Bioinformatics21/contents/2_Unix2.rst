Introduction to Unix 2
======================

General information
-------------------

Main objective
^^^^^^^^^^^^^^

In this lecture we will continue learning to use Unix-based systems. We will learn how to look at files and search them, how to control the flow of input and output to programs and responsible use of HPC clusters.

Learning objectives
^^^^^^^^^^^^^^^^^^^

* Students can search for and within files
* Students are familiar with commands for data wrangling
* Students can use pipes to control input and output, and combine commands
* Students are able to work responsibly on computing clusters

Resources
^^^^^^^^^

This section requires the use of the |R_Workbench|.

.. |R_Workbench| raw:: html

    <a href="https://rstudio-teaching.ethz.ch/auth-sign-in?appUri=%2F" target="_blank">R Workbench</a>


Searching
---------

Searching for a file
^^^^^^^^^^^^^^^^^^^^

When you are trying to find a file in your system, the command **find** offers a number of options to help you. The first argument is where to start looking (it looks recursively inside all directories from there), and then an option must be given to specify the search criteria.

.. code-block:: bash

    # Finding files
    find . -name "\*.txt"  # searches for files ending in .txt
    find . -mtime -2      # searches for files modified in the last two days
    find . -mtime +365    # searches for files modified at least one year ago
    find . -size +1G      # searches for files at least 1GB or larger
    find . -maxdepth 1    # searches only here, i.e.: doesn't look inside directories

.. admonition:: Exercises
    :class: exercise

    * Use **ls** to get a list of all files in the /nfs/course/genomes directory
    * Use **cp** to copy all files from the ecoli subdirectory into a new directory in your home directory
    * Navigate to the /nfs/course/genomes directory
    * Use **find** to look for all .faa files there
    * Use **find** to look for all files larger than 5MB
    * Now combine these criteria to find all .txt files larger than 5MB

    .. hidden-code-block:: bash

        # Make a directory for the new files
        cd ~
        mkdir ecoli

        # Copy all the files
        cp /nfs/course/genomes/bacteria/escherichia/* ~/ecoli/

        # Navigation
        cd /nfs/course/genomes

        # Looking for files
        find . -name "\*.faa"
        find . -size +5M
        find . -name "\*.faa" -size +5M

Searching in **less**
^^^^^^^^^^^^^^^^^^^^^

When you open a file to look at it using **less**, it is also possible to search within that file by pressing **/** (search forwards) or **?** (search backwards) followed by a pattern.

.. code-block:: bash

    # Finding strings
    /AAAAAAAAA  # finds the next instance of "AAAA"
    ?TTTTTTTTT  # finds the previous instance of "TTTT"

These same commands will also work with **man**, helping you to find a particular argument more easily.

But what happens when you search for "."? The entire document will be highlighted! Why is this?

Regular Expressions
^^^^^^^^^^^^^^^^^^^

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

.. code-block:: bash

    # name@domain.net can be matched as: \w+@\w+\.\w+
    echo "name@domain.net" | grep -E '\w+@\w+\.\w+'
    echo "name@domain.net" | grep -E '\w+@\w+'
    echo "name@domain.net" | grep -E '@\w+'

Grep
^^^^

The command **grep** allows you to search within files without opening them first with another program. It also uses regular expressions to allow for powerful searches, and has a number of useful options to help give you the right output.

.. code-block:: bash

    # A simple **grep**
    grep "AAAAAAAAA" E.coli.fna        # shows all lines containing "AAAAAAAAA" highlighted

    # Using grep with a regex
    grep -E "(ACGT)(ACGT)+" E.coli.fna # shows all lines containing "ACGTACGT.." highlighted

    # Useful options
    grep -o  # show only the matches
    grep -c  # show only a count of the matches

.. admonition:: Exercises
    :class: exercise

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
        less GCF_000005845.2_ASM584v2_cds_from_genomic.fna

        # Type this within less:
        /dnaA

        # Type 'n' or 'N' after to see if there are more search hits

        # Use grep
        grep 'dnaA' GCF_000005845.2_ASM584v2_cds_from_genomic.fna

        # Use grep to count
        grep -c '>' GCF_000005845.2_ASM584v2_cds_from_genomic.fna

        # Which entry number?
        grep '>' GCF_000005845.2_ASM584v2_cds_from_genomic.fna | grep -n 'dnaA'

Data wrangling
--------------

A lot of time and effort in bioinformatics is spent arranging data in the correct way or correct format (aka "data wrangling"). Consequently, it is very useful to know how to filter and rearrange data files. In these exercises, we will learn some of the commands we use to do this.

The command **sort** will sort each line of a file, alphabetically by default, but other options are available.

.. code-block:: bash

    # Sort some example files
    cat sort_words.txt
    sort /nfs/course/examples/sort_words.txt

    cat /nfs/course/examples/sort_nums.txt
    sort -n /nfs/course/examples/sort_nums.txt

The command **cut** allows you to extract a single column of data from a file, for instance a .csv or .tsv file.

.. code-block:: bash

    # Look at some experimental metadata and extract the column we are interested in
    less /nfs/course/examples/metadata.tsv
    cut -f 4 /nfs/course/examples/metadata.tsv

The command **paste** allows you to put data from different files into columns of the same file.

.. code-block:: bash

    # Put together two files into one
    paste /nfs/course/examples/sort_words.txt /nfs/course/examples/sort_nums.txt

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
    less /nfs/course/examples/uniq_nums.txt
    uniq /nfs/course/examples/uniq_nums.txt

    # Count how many times each value is repeated
    uniq -c /nfs/course/examples/uniq_nums.txt

.. admonition:: Exercises
    :class: exercise

    * Use the **sort** examples above and see what happens when you try to sort the *sort_nums.txt* file without the -n flag.
    * Look at the file */nfs/course/examples/sort_tab.txt*.
    * Extract the second column of this file using **cut**.
    * Looking at the manual for **sort**, can you figure out how to sort *sort_tab.txt* according to the second column, or 'key'?
    * Use **paste** to combine the two files *sort_words.txt* and *sort_nums.txt* (in the directory */nfs/course/examples/*) into a single two-column output.
    * Use **tr** so that when you enter the word *banana* it comes out as *rococo*.
    * Use the **uniq** examples above, then check with **uniq -c** that each line in *sort_tab.txt* is unique.

    .. hidden-code-block:: bash

        # Look at sort_tab.txt
        less /nfs/course/examples/sort_tab.txt

        # Extract the second column
        cut -f 2 /nfs/course/examples/sort_tab.txt

        # Sort the table by second column
        sort -n -k 2 /nfs/course/examples/sort_tab.txt
        # Note that if you forget the -n then the numbers are sorted alphabetically, not numerically

        # Use paste to combine files
        paste /nfs/course/examples/sort_words.txt /nfs/course/examples/sort_nums.txt

        # Use tr to convert one word into another
        tr 'ban' 'roc'
        # Then input banana and back comes rococo!

        # Check file with uniq
        uniq -c /nfs/course/examples/sort_tab.txt
        # Each value in the first column is 1 - no repeats!

Combining commands
------------------

The power of this set of commands comes when you use them together, and when you can save your manipulated data into a file. To understand how to do this we have to think about the command line input and output data.

Input and output
^^^^^^^^^^^^^^^^

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
    cp /nfs/course/genomes/bacteria/escherichia/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna E.coli.fna

    # Using the standard streams
    head < E.coli.fna                  # send the file to head via stdin using '<'
    head E.coli.fna > E.coli_head.fna  # send stdout to a new file using '>'
    head E.coli.fna 2> E.coli_err.fna  # send stderr to a new file using '2>'
    head E.coli.fna &> Ecoli_both.fna  # send both stdout and stderr to the same file using '&>'

Chaining programs together
^^^^^^^^^^^^^^^^^^^^^^^^^^

Sometimes you want to take the output of one program and use it in another -- for instance, run *grep* on only the first 10 lines of a file from *head*. This is a procedure known as **piping** and requires you to put the **|** character in between commands (although this may not work with more complex programs).

.. code-block:: bash

    # Copy and rename the file containing the E.coli open reading frames
    cd
    cp /nfs/course/genomes/bacteria/escherichia/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna E.coli_CDS.fna

    # Piping
    head E.coli.fna | grep "ACGT"                  # send the output of head to grep and search
    grep -A 1 ">" E.coli_CDS.fna | grep -c "^ATG"  # use grep to find the first line of sequence of each gene and send it to a second grep to see if the gene starts with ATG

.. admonition:: Exercises
    :class: exercise

    * Copy the file GCF_000005845.2_ASM584v2_cds_from_genomic.fna to your home and rename it to *E.coli_CDS.fna*
    * Use **grep** to find all the fasta headers in this file, remember that a fasta header line starts with '>'.
    * Send the output of this search to a new file called *cds_headers.txt*.
    * Use **grep** again to find only the headers with gene name information, which looks like, for instance [gene=lacZ], and save the results in another new file called named_cds.txt.
    * Use **wc** to count how many lines are in the file you made.
    * Now repeat this exercise **without** making the intermediate files, instead using pipes.

    As an additional challenge:

    * Using the commands we have used, find the start codon of each gene in *E. coli* and then count up the frequency of the different start codons.

    .. hidden-code-block:: bash

        # Copy the file to your home directory
        cp nfs/course/genomes/bacteria/escherichia/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna ~/E.coli_CDS.fna

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

Writing and running a script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you construct a series of commands that you want to perform repeatedly, you can write them into a **script** and then run this script instead of each command individually. This makes it less likely that you make an error in one of the individual commands, and also keeps a record of the computation you performed so that your work is reproducible.

You can write the script using a text editor on your computer, then uploading it, or in R Workbench. If you want to write a script directly in the terminal there are text editors available such as **vim** and **emacs** - you should be able to find tutorials for both online.

By convention, a script should be named ending in *.sh* and is run as follows:

.. code-block:: bash

    # Run a script in the same directory
    ./myscript.sh

    # Run a script in another directory
    ./mydir/myscript.sh

The command line interface, or shell, that we use is called **bash** and it allows you to use arguments in your scripts, encoded as variables *$1*, *$2*, etc.

For instance we could have a simple script:

.. code-block:: bash

    # myscript.sh
    echo "Hello, my name is $1"

.. code-block:: bash

    # Running my simple script
    ./myscript.sh Chris

    "Hello, my name is Chris"

This means you could write a script that performs some operations on a file, and then replace the file path in your code with *$1* to allow you to declare the file when you execute the script. Just remember that if your script changes working directory, the relative path to your file may be incorrect, so sometimes it is best to use the absolute path.

.. admonition:: Exercise
    :class: exercise
    
    * Write a simple script that will count the number of entries in a fasta file
    * Use a variable to allow you to declare the file when you run the script
    * Test it on each of the fasta files in the /nfs/course/genomes subdirectories

Working on Morgan
-----------------

The module system
^^^^^^^^^^^^^^^^^

There are hundreds of programs and software suites that people might want to use on the server. Whilst everyone is welcome to install each one they use for themselves, it's more sensible to make the most common packages available for everyone. Further, different pieces of software have different dependencies, which may in some cases disagree with each other -- for instance, whether to use Python 2.x or 3.x.

One way to resolve this is to use a **module system**, from which different software packages can be loaded and unloaded individually. This is not the same as installing the programs - they were there all along - it's simply making them available in your **path** -- a generic term for all of the programs and libraries your system is immediately aware of, without having to be shown where they are.

As an example, let's load up the module for **prodigal**, a program for finding ORFs in prokaryotic genome sequences.

.. code-block:: bash

    # Loading a module
    module load prodigal
    ml prodigal

Now if we issue the command *prodigal* the program loads straight from the command line. Note that *module* can be shortened to *ml*, and if you just put a module name it is assumed you want to load it.

It's also possible to unload modules:

.. code-block:: bash

    # Unloading a module
    module unload prodigal

    # Unload all modules
    ml purge

Now if you try to run *prodigal*, it won't recognise the command.

There are also commands to show which modules you have loaded, and which modules are available to load. If you want to run a particular piece of software and it isn't available, let me know and I can see about making it available for you.

.. code-block:: bash

    # What have I loaded?
    module list
    ml

    # What can I load?
    ml avail

Finally, if you want to search for a particular piece of software by name (or to find out the correct name, given that module names are case-sensitive), there is the command **spider**:

.. code-block:: bash

    # Search for a module
    ml spider blast

The SGE queuing system
^^^^^^^^^^^^^^^^^^^^^^

Many people have access to *morgan* and even more to *euler*. If everyone ran whatever program they liked, whenever they liked, the system would soon grind to a halt as it tried to manage the limited resources between all the users. To prevent this, and to ensure fair usage of the server, we run a queueing system that automatically manages which jobs are run when. Any program that will use either more than 1 core or thread, more than a few GB of RAM, or will run for longer than a few minutes, should be placed in the queue.

To correctly submit a job to the queue on *morgan*, it's usually easiest to write a short shell script based on a template.

.. code-block:: bash

    # Look at the template
    less /nfs/course/examples/submit.sh

.. code-block:: none

    #$ -cwd                   # run in current directory
    #$ -S /bin/bash           # interpreting shell for the job
    #$ -N job1                # name of the job
    #$ -V                     # .bashrc is read in all nodes
    #$ -pe smp 10             # number of threads to be reserved
    #$ -l h_vmem=16G          # memory required
    #$ -e error.log           # error file
    #$ -o out.log             # output file
    #$ -m bea                 # send an email at the beginning, end and if aborted
    #$ -M yourmail@ethz.ch

    # Insert your commands here
    echo 'Hello World!'

The first few lines, beginning with *#$*, define the parameters for your job. The commands you want to run then appear below, and you can include as many as you like, one per line, which will run in succession.

When the script is ready, you will need the following commands:

.. code-block:: bash

    # Submit the job to the queue
    qsub submit.sh

    # Check the status of your jobs
    qstat

    # Check the status of all jobs
    qstat -u "*"

    # Remove a job from the queue
    qdel jobid


The LSF queuing system (euler)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: none

    #!/bin/bash
    #BSUB -n 10                                 # number of threads
    #BSUB -W 1440                               # estimated time to run
    #BSUB -R "rusage[mem=2000, scratch=2000]"   # memory and disk space needed
    #BSUB -e error.log                          # error file
    #BSUB -o out.log                            # output file
    #BSUB -u yourmail@ethz.ch                   # specify your email address
    #BSUB -B                                    # send email when job starts
    #BSUB -N                                    # send email when job ends

    # Insert your commands here
    echo 'Hello World!'

Then the equivalent commands:

.. code-block:: bash

    # Submit the job to the queue
    bsub < submit_lsf.sh

    # Check the status of your jobs
    bjobs

    # Remove a job from the queue
    bkill jobid

.. admonition:: Exercises
    :class: exercise

    * You must do this exercise on **morgan**
    * Copy the submit.sh script to your home directory.
    * Load the 'prodigal' module and find out the program options
    * Change the 'echo' line to load the module for *prodigal* and then run the program on the *E. coli* genome.
    * You shouldn't need more than 8 slots or 1GB of memory per slot.
    * When the job is finished, look at the output files for yourself!

    .. hidden-code-block:: bash

        # Copy the script
        cp /nfs/course/examples/submit.sh ~/

        # Load the prodigal module for yourself
        module load prodigal

        # Read the options for the program
        prodigal -h

        # Edit the submit script by replacing the 'echo' line to this:
        module load prodigal
        prodigal -i ecoli.fna -o ecoli_genes.fna

        # Submit the script to the queue
        qsub submit.sh

        # Look at the output
        less ecoli_genes.fna

.. admonition:: Homework
    :class: homework
       
    Much like a spoken language, learning a new computing language is easier with repetition. To help you organise your learning, you should create a cheat sheet for the commands that you have learnt over the last two sessions. Feel free to search online for inspiration on how to lay this out. Consider that you need to know the command name, what it does, what options it has that you might use (just the ones you think most useful of course) and what arguments it requires. You might also like to sort them by purpose as we have tried to introduce them here, i.e.: navigation, file operations, etc.

    Upload your cheatsheet in whatever format you like to your home directory and we will review them next time.

