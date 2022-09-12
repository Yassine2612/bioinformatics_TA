Image analysis 3
================

General information
-------------------

Resources
^^^^^^^^^

This section requires the use of the R Workbench according to your **surname**:

* A-J: `Server 01 <https://rstudio-teaching-01.ethz.ch/>`__
* K-R: `Server 02 <https://rstudio-teaching-02.ethz.ch/>`__
* S-Z: `Server 03 <https://rstudio-teaching-03.ethz.ch/>`__

Introduction to Bioimage Analysis
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This material has been taken from the book *Introduction to Bioimage Analysis* by Pete Bankhead, available in full `here <https://bioimagebook.github.io/README.html>`__. We reproduce it here according to the Creative Commons license CC BY 4.0, explained in full `here <https://creativecommons.org/licenses/by/4.0/>`__. We are reproducing excerpts from the book, and the only changes made have been in formatting. We encourage you to read the entire book if you are interested in learning more about bioimage analysis.

Measurements & histograms
-------------------------

Images & pixels demonstrated how looks can be deceiving: the visual appearance of an image isn’t enough to determine what data it contains.

Because scientific image analysis depends upon having the right pixel values in the first place, this leads to the important admonition:

**Keep your original pixel values safe!:** The pixel values in your original image are your raw data: it’s essential to protect these from unwanted changes.

This is really important because there are lots of ways to accidentally compromise the raw data of an image – such as by using the wrong software to adjust the brightness and contrast, or saving the files in the wrong format. This can cause the results of analysis to be wrong.

What makes this especially tricky is that trustworthy and untrustworthy images can look identical. Therefore, we need a way to see beyond LUTs to compare the content of images easily and efficiently.

Comparing histograms & statistics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In principle, if we want to compare two images we could check that every corresponding pixel value is identical in both images. We will use this approach later, but isn’t always necessary.

There are two other things we can do, which are often much faster and easier:

1. Calculate some summary statistics from the pixel values, such as the average (mean) pixel value, standard deviation, minimum and maximum values.

2. Check out the image histogram. This graphically depicts the distribution of pixel values in the image.

Putting these into action, we can recreate Fig. 4 but this time add

1. the LUT (shown as a colored bar below the image)

2. a histogram

3. summary statistics

.. thumbnail:: images/measurements_4_0.png
    :align: center

.. admonition:: Fig. 10
    :class: caption
    
    Recreation of Fig. 4 showing images that look the same, but contain different pixels values – this time with measurements and histograms included.

With the additional information at our disposal, we can immediately see that the images really do contain different underlying values – and therefore potentially quite different information – despite their initial similar appearance. We can also see that the LUTs are different; they show the same colors (shades of gray), but in each case these map to different values.

By contrast, when we apply the same steps to Fig. 5 we see that the histograms and statistics are identical – only the LUT has been changed in each case. This suggests that any analysis we perform on each of these images should give the same results, since the pixel values remain intact.

.. thumbnail:: images/measurements_6_0.png
    :align: center

.. admonition:: Fig. 11
    :class: caption
    
    Recreation of Fig. 5 showing images that look different, but contain the same pixel values – this time with measurements and histograms included.

.. admonition:: Exercise 13.1
   :class: exercise

    If two images have identical histograms and summary statistics (mean, min, max, standard deviation), does this prove that the images are identical?

    .. hidden-code-block:: bash

        The ability to quickly generate and interpret histograms is an essential skill for any image analyst. We will use histograms a lot throughout this text, both to help diagnose problems with the data and to figure out which techniques we should use.

**Make histograms a habit!:** When working with new images, it’s a good habit to always check histograms. This can give a deeper understanding of the data, and help flag up potential problems.

Image processing & analysis
---------------------------

Successfully extracting useful information from microscopy images usually requires triumphing in two main battles.

The first is to overcome limitations in image quality and make the really interesting image content more clearly visible. This involves image processing, the output of which is another image. The second is to compute meaningful measurements, which could be presented in tables and summary plots. This is image analysis.

Our main goal here is analysis – but processing is almost always indispensable to get us there.

An image analysis workflow
^^^^^^^^^^^^^^^^^^^^^^^^^^

So how do we figure out how to analyze our images?

Ultimately, we need some kind of workflow comprising multiple steps that eventually take us from image to results. Each individual step might be small and straightforward, but the combination is powerful.

I tend to view the challenge of constructing any scientific image analysis workflow as akin to solving a puzzle. In the end, we hope to extract some kind of quantitative measurements that are justified by the nature of the experiment and the facts of image formation. One of the interesting features of the puzzle is that there is no single, fixed solution.

Although this might initially seem inconvenient, it can be liberating: it suggests there is room for lateral thinking and sparks of creativity. The same images could be analyzed in quite different ways. Sometimes giving quite different results, or answering quite different scientific questions.

Admittedly, if no solution comes to mind after pondering for a while then such an optimistic outlook quickly subsides, and the ‘puzzle’ may very well turn into an unbearably infuriating ‘problem’ – but the point here is that in principle image analysis can be enjoyable. What it takes is:

* a modicum of enthusiasm (please bring your own)

* properly-acquired data, including all the necessary metadata (the subject of Part I)

* actually having the tools at your disposal to solve the puzzle (the subject Part II)

If you’re a reluctant puzzler then it also helps to have the good luck not to be working on something horrendously difficult, but that is difficult to control.

Combining processing tools
^^^^^^^^^^^^^^^^^^^^^^^^^^

Image processing provides a whole host of tools that can be applied to puzzle-solving. When piecing together processing steps to form a workflow, we usually have two main stages:

1. Preprocessing: the stuff you do to clean up the image, e.g. subtract the background, use a filter to reduce noise

2. Segmentation: the stuff you do to identify the things in the image you care about, e.g. apply a threshold to locate interesting features

Having successfully navigated these stages, there are usually some additional tasks remaining (e.g. making measurements of shape, intensity or dynamics). However, these depend upon the specifics of the application and are usually not the hard part. If you can identify what you want to quantify, you’re a long way towards solving the puzzle.

Fig. 56 shows an example of how these ideas can fit together.

.. thumbnail:: images/processing_and_analysis_3_0.png
    :align: center

.. admonition:: Fig. 56
    :class: caption
    
    A simple image analysis workflow for detecting and measuring spots in an image.

It won’t be possible to cover all image processing tools in a book like this. Rather, we will focus on the essential ones needed to get started: thresholds, filters, morphological operations and transforms.

These are already enough to solve many image analysis puzzles, and provide the framework to which more can be added later.
