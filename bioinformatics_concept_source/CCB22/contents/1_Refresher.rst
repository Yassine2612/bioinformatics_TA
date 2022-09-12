Refresher
======================

General information
-------------------

Main objective
^^^^^^^^^^^^^^

In this lecture we will introduce **Unix**: an operating system that runs on almost all high performance computing (HPC) servers, which we interface with via the **command line**.

Learning objectives
^^^^^^^^^^^^^^^^^^^

* Students can use the command line to issue basic commands with arguments
* Students can navigate the Unix file system and perform basic file operations
* Students can inspect files

Resources
^^^^^^^^^

This section requires the use of your terminal. We will connect to **Euler** and train some basic commands there.

Networks
--------

Computers have been connected to each other to exchange data since the 1950s and now we take internet access for granted on our mobile devices. Behind the screen, there are countless pieces of software and protocols that make everything work, but we won't go into the details.

.. thumbnail:: images/client_server_model.png
    :align: center

It is important however to understand the concept of a **remote server**. This is a computer sitting somewhere, possibly in the ETH basement, possibly in an enormous data centre in Iceland, which is only supposed to be connected to over the internet. To be able to connect to a server you need to have appropriate access - a username and password - and perhaps you will have to be connecting from an allowed location. For instance, you can only access the ETH remote servers from within the ETH domain, either because you are on the ETH WiFi or have connected via **VPN**.

**VPN**, or **V**\irtual **P**\rivate **N**\etwork, is a way of connecting to a server that then channels all of your internet traffic through the server as if you were in its location. So if you use the ETH VPN, you will have access to everything as if you were connected to the ETH WiFi or cable network.

If you have not already connected your devices with the ETH VPN you can find the instructions to do so `here <https://ethz.ch/content/dam/ethz/special-interest/hest/isg-hest-dam/documents/pdf/vpn-de.pdf>`__.


.. admonition:: Exercises 0.1
    :class: exercise

    * Try to find out your IP-address before connecting to the ETH VPN. You can do so by going to the website `Hoststar <https://www.hoststar.ch/de/tools/meine-ip-adresse#:~:text=Geben%20Sie%20den%20Befehl%20»ping,öffentliche%20IP-Adresse%20der%20Seite.>`__.
    * Now connect to the ETH VPN and check your IP-address once more at `Hoststar <https://www.hoststar.ch/de/tools/meine-ip-adresse#:~:text=Geben%20Sie%20den%20Befehl%20»ping,öffentliche%20IP-Adresse%20der%20Seite.>`__. What do you notice?

    .. hidden-code-block:: bash

       # You should notice that your IP-address change even though you did not physically change your location.

Command line interface
----------------------

Although software exists which allows you to access a server just as if you were logging into a normal computer - with a graphical user interface and everything - many will only provide a **command line interface**. This is a text-based method of communication that almost all computers have, though it is typically hidden out of sight for most users.

The terminal functions like an old fashioned text adventure game, or a voice-activated assistant that requires you to type in your commands.

.. thumbnail:: images/command_line.gif

Accessing the command line interface on your own computer depends on your system:

Windows
^^^^^^^

* In the taskbar menu type 'command' and Command Prompt should appear for you to launch
* Alternatively press Windows Key + r and type 'cmd' into the box and Command Prompt should launch

Mac
^^^

* Click the launchpad icon in the dock, type 'Terminal' into the search field and launch from there
* Alternatively in the Finder, navigate to /Applications/Utilities folder and launch Terminal from there

Connecting to a remote server
-----------------------------

Your local computer is often not capable of doing bioinformatic work within a reasonable time. Therefore, in order to do bioinformatics, you have to connect to remote servers which have higher capacities than your local machine. ETH provides to its members access to a server named **Euler**, which can be accessed at the address: :code:`euler.ethz.ch`. Bioinformatic labs often have in addition their own remote servers.
In order to work on a server, you have to connect to it using a protocol called **S**\ ecure **Sh**\ ell or **ssh**.
The ssh structure usually is <your-ID>@<server-address> (Note: **<** and **>** are not part of the command) in case of Euler this is <yourETH-ID>@euler.ethz.ch, so the command to connect for Euler is.

.. code-block:: bash

    # Command to connect to euler
    ssh <yourETH-ID>@euler.ethz.ch

.. admonition:: Exercise 0.2
    :class: exercise

        * Try to connect to Euler yourself

    .. hidden-code-block:: bash

        # First, you have to open the command line interface on you computer
        # For Windows: Type "command" into the taskbar menu
        # For Mac: Click onto the launchpad icon in the dock and type "Terminal" into the search field

        # Second, connect to Euler with the ssh command. You need your  user ID and your nethz password in order to connect to the serve. The command to connect to the Euler is:
        ssh <yourETH-ID>@euler.ethz.ch

        # Please note that the first time you access Euler, ETH will send you an additional verification code to your ETH-mail.**
        # This code has to be entered into the terminal in order to access Euler.



The command
-----------

Commands are our tool to tell the computer what to do. Most commands have *options* and *arguments*. Arguments are often essential for a command to operate properly; they are the pieces of information required by a command, such as a file name. Options are, of course, optional, and offer ways to modify the way the command works.

.. thumbnail:: images/command_structure.png
    :align: center

For instance, **echo** will take any text you give it as an argument and then send it back to you as output:

.. code-block:: bash

    # My first command
    echo 'Hello World!'

If you use the option *-n*, then it will not add a 'new line' to the end of the output:

.. code-block:: bash

    # My second command
    echo -n 'Hello World!'

Some commands end up with very complex structures, because they can have many options and arguments. In general, options will be of the format ``-a`` where a is a single letter or ``--word`` where word is a string (a series of letters, in computer terms).

**Note:** the command line is case-sensitive! So it **does** matter if you write *-a* or *-A*.

Getting help
^^^^^^^^^^^^

The **man** command will show a manual for most basic commands, providing the correct syntax to use it and the various options available.

.. code-block:: bash

    # Read the manual
    man ls

Other programs have different ways to provide help on how to use them. An online tutorial is best, or a comprehensive manual, but sometimes you only have the command line to help you.

.. code-block:: bash

    # Help please!
    python3 -h
    python3 --help

Useful command line tricks
^^^^^^^^^^^^^^^^^^^^^^^^^^

* You can use the **up and down arrow keys** to navigate through previously used commands (known as your history) and repeat or modify them.

* Windows: To copy text from the terminal you will have to highlight it and right-click to use the in-browser menu and copy. Similarly you have to use the in-browser menu to paste into the terminal. The reason for this is that *Ctrl + c* and *Ctrl + v* have effects inside the terminal.

* Mac: You can fortunately use *Cmd + c* and *Cmd + v* to copy and paste as normal. You can use *Ctrl* and various keys for in-terminal commands.

* When typing a command or file name, you can press the 'tab' key to **auto complete** what you are typing. If there are multiple commands or files with similar names, auto completion will fill in as far as the first ambiguous character before you have to give it some more input. This method makes it *much* less likely that you make a spelling error. Also, if you double press the 'tab' key all the available options to complete will be shown.

* Pressing **Ctrl + c** will send an interrupt signal that cancels the currently running command and brings you back to the command line.

* Pressing **Ctrl + r** will allow you to search through your command history.

* Pressing **Ctrl + l** will clear the screen.

* See previous commands by typing **history** and pressing enter.

* Double-click to select a word, triple-click to select a line

* Using a **#** character allows you to make comments that have no effect when run.

.. admonition:: Exercise 1.1
    :class: exercise

    * Try to *echo* "My first command"
    * Use the arrow key to execute the same command again
    * Try typing *e* then pressing tab twice, what do you see?
    * Try adding *c* to make *ec* and pressing tab again. What happens?
    * Try to copy/paste your *echo* command "echo 'My first command'"
    * Try to clear the screen, can you still paste your *echo* command?
    * Try to *echo* 'My first command 'once with the *-n* option and once with the *-N* option. What do you notice?

    .. hidden-code-block:: bash

        #echoing "My first command"
        echo 'My first command'

        # Press the up arrow once and the last command appears
        echo 'My first command'

         # You see all the possible commands that start with "e" when you press tab twice after entering “e”
        e2freefrag             edquota                era_check              eu-readelf
        e2fsck                 efibootdump            era_dump               eu-size
        e2image                efibootmgr             era_invalidate         eu-stack
        e2label                efikeygen              era_restore            eu-strings
        e2mmpstatus            efisiglist             esac                   eu-strip
        e2undo                 efivar                 escputil               eutp
        e4crypt                egrep                  espdiff                eu-unstrip
        e4defrag               eject                  espeak-ng              eval
        eapol_test             elfedit                ether-wake             evince
        easy_install-2         elif                   ethtool                evince-previewer
        easy_install-2.7       else                   eu-addr2line           evince-thumbnailer
        easy_install-3         enable                 eu-ar                  evmctl
        easy_install-3.6       encguess               eu-elfclassify         ex
        ebtables               enchant-2              eu-elfcmp              exec
        ebtables-restore       enchant-lsmod-2        eu-elfcompress         exempi
        ebtables-save          enscript               eu-elflint             exit
        echo                   env                    eu-findtextrel         exiv2
        ed                     envsubst               eu-make-debug-archive  expand
        edgepaint              eog                    eu-nm                  export
        edid-decode            eps2eps                eu-objdump             exportfs
        editdiff               eqn                    eu-ranlib              expr

        # The command autocompletes after adding the “c” to the “e”
        echo

        # Note that ctrl + c and ctrl + v does not work on windows and you have to right click
        echo 'My first command'

        # To clear the screen use ctrl + l and you can still paste the command
        echo 'My first command'

        # echo -n does not add a new line to the output
        echo -n 'My first command'
        My first command[]$

        # The -N option does not exist therefore “echo” will ill interpret '-N' as characters to display
        echo -N 'My first command'
        -N My first command


The file system
---------------

You may be used to the file system in Windows or Mac OS X, where directories can contain files and more directories. The Unix filesystem is structured in the same way - as a tree - that begins at the 'root' directory '**/**'. Directories are separated by slash characters **/**.

When you work on the command line, you are located in a directory somewhere in this tree. There are two ways to refer to a location: its **absolute path**, starting at the root directory, or its **relative path**.

.. code-block:: bash

    # Absolute path
    /cluster/home/<user_name>

    # Relative path
    ../../home/<user_name>

The **..** refers to the directory above a location, so the relative path here goes up twic, then back down to your home directory. If a path starts with **~/** then it refers to your home directory. If a path starts with **./** then it refers to the current directory.

.. code-block:: bash

    # References the level above
    ../

    # References the home directory
    ~/

    # References the current directory
    ./

Navigation
^^^^^^^^^^

**pwd** will tell you exactly where you are in the file system. If you imagine the tree structure, **pwd** tells you on which branch of the tree you are sitting. You will start off in your home folder.

.. code-block:: bash

    # Where am I?
    pwd

**ls** will list all of the files and directories where you are currently located. Put another way, **ls** tells you all the branches that go out of the branch you are sitting on. If you give a path as an argument (the route to another branch), it will list the files at that location (the branches that go out from that branch).

.. code-block:: bash

    # What is here?
    ls

**cd** will change your location (the branch you are sitting on), your 'working directory', to the path given, absolute or relative. If no address is given, you return to your home directory.

.. code-block:: bash

    # Going back one step and check where you are
    cd ..
    pwd

    # Going back to previous directory
    cd -
    pwd

    # Going to your home directory
    cd
    pwd

    # Going to the root
    cd /
    pwd


.. admonition:: Exercise 1.2
    :class: exercise

    * Use *pwd* to find out where you are in your command line session
    * Use *ls* to see if you have any files in your home directory
    * Use *cd* to go up one level
    * Use *ls* to see all the home directories of other users on the server
    * Try to go up two levels using cd
    * Use cd to go back to your home directory
    * Go to the root and check what is there
    * Go home

    .. hidden-code-block:: bash

        #use pwd to find you current location
        pwd
         /cluster/home/<your eth name>

        #Use ls to see what in the directory is.
        ls

        #Use cd to change directory and .. to go up one level
        cd ..

        #Use ls to see what is in the directory
        ls

        #use cd to change directory and .. to go up one level
        cd ../..

        #To get to the home directory just typing cd
        cd

        # Go to thr root and check what is there
        cd /
        ls

        # Finally let's go home
        cd

Wildcards
^^^^^^^^^

When providing a file path as an argument to a command, it is often possible to provide multiple file paths using *wildcards*. These are special characters or strings that can be substituted for a matching pattern. For many commands using wildcards allows you to execute the associated action on each file that matches the pattern, though this obviously does not work in all cases.

* **?** matches any single character
* \* matches any number of any characters
* **[...]** matches any character within the brackets
* **{word1,word2,...}** matches any string inside the brackets

For instance:

.. code-block:: bash

    # Pattern matching
    ls /cluster/home/*      # lists all files in the ecoli directory
    ls /cluster/home/*.fna  # lists all nucleotide fasta files there
    ls /cluster/home/*.f?a  # lists all nucleotide and protein fasta files there

Basic file operations
---------------------

**cp** copies a file from one location to another. The example will copy a file containing the genome sequence of *E. coli K12 MG1655* to your home directory.

.. code-block:: bash

    # Copy
    cp <source> <destination>

**mv** moves a file from one location to another. The example actually renames the file, because the destination is not a directory. Thus you can move and rename a file with the same command.

.. code-block:: bash

    # Move or rename
    mv <source> <destination>

**rm** removes a file, so use it with care.

.. code-block:: bash

    # Remove
    rm <path_to_file>

**mkdir** creates a new directory with the given name.

.. code-block:: bash

    # Make directory
    mkdir <path to directory>
    mkdir genomes

**rmdir** removes an empty directory.

.. code-block:: bash

    # Remove an empty directory
    rmdir <path to directory>
    rmdir genomes

.. admonition:: Exercise 1.3
    :class: exercise

    * Create two new directories called "genomes" and "homework" in your home folder
    * Using the *man* and *cp*, find out how to copy a directory.

    .. hidden-code-block:: bash

        # First go to your home folder
        cd
        # Use the mkdir function to create a directory
        mkdir genomes
        mkdir homework

        # Enter home directory
        cd
        # Create two directory
        mkdir dir1
        mkdir dir2

        # Try to copy dir1 into dir2
        cp dir1 dir2
        cp: dir1 is a directory (not copied).

        # If you check 'man cp', you see that you have to use -R:
        man cp
        cp -R dir1 dir2


File name conventions
^^^^^^^^^^^^^^^^^^^^^

In Unix systems there are only really two types of files: text or binary. The file name ending (.txt or .jpg) doesn't really matter like it does in Windows or Mac OS, however it is used to indicate the file type by convention. Some file types you will encounter include:

* .txt - A generic text file.
* .csv - A 'comma separated values' file, which is usually a table of data with each line a row and each column separated by a comma.
* .tsv - A 'tab separated values' file, which is the same but separated by tab characters.
* .fasta or .fa - A fasta formatted sequence file, in which each sequence has a header line starting with '>'.
* .fna - A fasta formatted nucleotide sequence file, usually gene sequences.
* .faa - A fasta formatted protein sequence file.
* .sh - A 'shell script', which contains commands to run.
* .r - An R script, which contains R commands to run.
* .py - A python script, which contains python commands to run.
* .gz or .tar.gz - A file that has been compressed using a protocol called 'gzip' so that it takes up less space on the disk and transfers over the internet faster.

Other useful file operations
----------------------------

Transferring files between computers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are many different protocols for transferring files between computers. You may have heard of **FTP** - **F**\ile **T**\ransfer **P**\rotocol - which is a non-secure but commonly used example. A more secure file transfer protocol is **SCP** - **S**\ecure **C**\opy **P**\rotocol, and programs such as *WinSCP* use it. The command **scp** is an easy way to transfer a file immediately between the server you are working on and another (or two different servers!). Another command to copy files is **rsync**, which can be used with many options such as preserving the ownership and date of creation of a file (and much more).

Tip: Remember that with the 'tab ' key you can auto complete and see the available options by double pressing. This can make finding a file you want to upload way easier. (Note: This works only for the machine you are currently on.)

.. code-block:: bash

    # Secure CoPy
    man scp
    scp source user@server:destination # local to server
    scp user@server:source destination # server to local

    # Rsync
    man rsync
    rsync -a source user@server:destination # local to server
    rsync -a user@server:source destination # server to local

Sometimes you want to download a file directly from the internet to the server, rather than going via your local machine. **wget** allows you to download files in this way.

.. code-block:: bash

    # Download from the internet
    wget source-URL
    wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/482/265/GCF_000482265.1_EC_K12_MG1655_Broad_SNP/GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna.gz


Compressing and decompressing files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Files can be compressed to take up less space on the hard drive (disk), or for transfer over the internet. The file you downloaded is an example, and we can decompress it using the **gunzip** command:

.. code-block:: bash

    # Decompress a file
    gunzip GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna.gz

If you ever need to compress a file, for instance to send it to someone, you can use the **gzip** command:

.. code-block:: bash

    # Compress a file
    gzip GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna

.. admonition:: Exercise 1.4
    :class: exercise

    * Download the E. coli file in the example above to your home folder.
    * Decompress the file.
    * Rename the file E.coli_K12_MG1655.fna (hint use move)

    .. hidden-code-block:: bash

        # Make sure I am in my home directory
        cd ~


        # Download the file
        wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/482/265/GCF_000482265.1_EC_K12_MG1655_Broad_SNP/GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna.gz


        # Decompress it
        gunzip GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna.gz

        # Rename the file
        mv GCF_000482265.1_EC_K12_MG1655_Broad_SNP_genomic.fna E.coli_K12_MG1655.fna

Working with files
------------------

Looking at files
^^^^^^^^^^^^^^^^

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

.. admonition:: Exercise 1.5
    :class: exercise

    * Use **cat** to look at the *E. coli* genome file you copied last time, is it suitable for looking at this file?
    * Use **head** and **tail** to examine the first and last 10 lines of the genome file. Now try to look at the first and last 20 lines.
    * Use **less** to look at the genome file. Navigate through the file with the keys listed above, then return to the Terminal.
    * Use the **man** command we learned to read about the **wc** command.
    * Can you find out how many lines are in the genome file with the **wc** command?

    .. hidden-code-block:: bash

        # Looking at the file
        cat E.coli_K12_MG1655.fna
        # Press ctrl + c to cancel the command

        # Look at the first 10 lines (10 is the default value)
        head E.coli_K12_MG1655.fna

        # Look at the last 10 lines
        tail E.coli_K12_MG1655.fna

        # Look at the first 20 lines
        head -n 20 E.coli_K12_MG1655.fna

        # Look at the last 20 lines
        tail -n 20 E.coli_K12_MG1655.fna

        # Looking at the genome file
        less E.coli_K12_MG1655.fna
        #press q to quit

        # Read about the wc command
        man wc

        # Count the number of lines in the file
        wc -l E.coli_K12_MG1655.fna


Searching
---------

Searching for a file
^^^^^^^^^^^^^^^^^^^^

When you are trying to find a file in your system, the command **find** offers a number of options to help you. The first argument is where to start looking (it looks recursively inside all directories from there), and then an option must be given to specify the search criteria. Here are some examples

.. code-block:: bash

    # Finding files ("." stands for the current directory you are in)
    find . -name "*.txt" -type f  # searches for files ending in .txt. The type option defines the type of the file.
    find . -mtime -2              # searches for files modified in the last two days
    find . -mtime +365            # searches for files modified at least one year ago
    find . -size +1G              # searches for files at least 1GB or larger
    find . -maxdepth 1            # searches only here, i.e.: doesn't look inside directories

Searching in **less**
^^^^^^^^^^^^^^^^^^^^^

When you open a file to look at it using **less**, it is also possible to search within that file by pressing **/** (search forwards) or **?** (search backwards) followed by a pattern.

.. code-block:: bash

    # Finding strings
    /AAAA  # finds the next instance of "AAAA"
    ?TTTT  # finds the previous instance of "TTTT"

These same commands will also work with **man**, helping you to find a particular argument more easily.

But what happens when you search for "."? The entire document will be highlighted! Why is this?

Regular Expressions
^^^^^^^^^^^^^^^^^^^

The reason this happens is that in the context of these search functions, "." represents *any character*. It is acting as a wildcard, from a different set of wildcards to those discussed in Unix1.

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
    grep "AAAAAAAAA" E.coli_K12_MG1655.fna        # shows all lines containing "AAAAAAAAA" highlighted

    # Using grep with a regex
    grep -E "(ACGT)(ACGT)+" E.coli_K12_MG1655.fna # shows all lines containing "ACGTACGT.." highlighted

    # Useful options
    grep -o  # show only the matches
    grep -c  # show only a count of the matches

.. admonition:: Exercise 2.2
    :class: exercise

    * Use **less** to look at the *E.coli_K12_MG1655.fna* file, containing nucleotide gene sequences.
    * Search within less to find the sequence for **AATTTGCCCGTTG**.
    * Use **man** to look at the **grep** command
    * Use **grep** to find the same entry in the file.
    * Use **grep** to count how many '>' enteries the file has.
    * If you are interested in learning regular expressions, try the exercises `here <https://regexone.com/>`__

    .. hidden-code-block:: bash

        # Look at the file
        less GCF_000005845.2_ASM584v2_cds_from_genomic.fna

        # Type this within less:
        /AATTTGCCCGTTG
        # Type 'n' or 'N' after to see if there are more search hits (there should be two)

        #Looking at grep
        man grep

        #Using grep to search for dnaA
        grep 'AATTTGCCCGTTG' E.coli_K12_MG1655.fna

        # Use grep to count
        grep -c '>' E.coli_K12_MG1655.fna


Data wrangling
--------------

A lot of time and effort in bioinformatics is spent arranging data in the correct way or correct format (aka "data wrangling"). Consequently, it is very useful to know how to filter and rearrange data files. In these exercises, we will learn some of the commands we use to do this.

The command **sort** will sort each line of a file, alphabetically by default, but other options are available.

.. code-block:: bash

    # Sort some example files
    sort E.coli_K12_MG1655.fna

    #Sorting nummerically with the -n option
    sort -n E.coli_K12_MG1655.fna

The command **cut** allows you to extract a single column of data from a file, for instance a .csv or .tsv file.


The command **paste** allows you to put data from different files into columns of the same file.


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

The command **uniq** compresses adjacent repeated lines into one line, and is best used with sort when combining commands.

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
    cp E.coli_K12_MG1655.fna E.coli.fna

    # Using the standard streams
    head < E.coli.fna                  # send the file to head via stdin using '<'
    head E.coli.fna > E.coli_head.fna  # send stdout to a new file using '>'
    head E.coli.fna 2> E.coli_err.fna  # send stderr to a new file using '2>'
    head E.coli.fna &> Ecoli_both.fna  # send both stdout and stderr to the same file using '&>'

Chaining programs together
^^^^^^^^^^^^^^^^^^^^^^^^^^

Sometimes you want to take the output of one program and use it in another -- for instance, run *grep* on only the first 10 lines of a file from *head*. This is a procedure known as **piping** and requires you to put the **|** character in between commands (although this may not work with more complex programs).

.. code-block:: bash

    # Piping
    head E.coli.fna | grep "ACGT"                  # send the output of head to grep and search


Writing and running a script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you construct a series of commands that you want to perform repeatedly, you can write them into a **script** and then run this script instead of each command individually. This makes it less likely that you make an error in one of the individual commands, and also keeps a record of the computation you performed so that your work is reproducible.


By convention, a script should be named ending in *.sh* and is run as follows:

.. code-block:: bash

    # Run a script in the same directory
    ./myscript.sh

    # Run a script in another directory
    ./mydir/myscript.sh

The command line interface, or shell, that we use is called **bash** and it allows you to use arguments in your scripts, encoded as variables *$1*, *$2*, etc.

For instance we could have a simple script:

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

.. admonition:: Exercise 2.5
    :class: exercise

    * Write a simple script that will count the number of A in a file
    * Use a variable to allow you to declare the file when you run the script
    * Make your script *executable* with the command "chmod +x myscript.sh"
    * Test it on some of the fasta files in the ``/nfs/course/551-0132-00L/1_Unix1/genomes`` subdirectories

    .. hidden-code-block:: bash

        # Simple script to count fasta entries in a file, fastacount.sh:
        grep -c "A" $1

        # Make it executable
        chmod +x Acount.sh

        # Run the script
        ./Acount.sh E.coli_K12_MG1655.fna # 57988


Working on a computing cluster
------------------------------

The LSF Queuing System
^^^^^^^^^^^^^^^^^^^^^^

Many people have access to *euler*. If everyone ran whatever program they liked, whenever they liked, the system would soon grind to a halt as it tried to manage the limited resources between all the users. To prevent this, and to ensure fair usage of the server, there is a queueing system that automatically manages which jobs are run when. Any program that will use either more than 1 core or thread, more than a few MB of RAM, or will run for longer than a few minutes, should be placed in the queue.

To correctly submit a job to the queue on *euler*, it's usually easiest to write a short shell script based on a template.

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

