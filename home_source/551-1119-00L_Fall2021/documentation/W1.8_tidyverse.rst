Data Transformation with **tidyverse**
======================================

Learning Goals
---------------

In this tutorial you will learn the basics of data manipulation using the tidyverse grammar. Specifically you will learn:

* The difference between tibbles and data frames
* How to arrange data
* How to filter observations
* How to select and create new variables
* How to summarise data
* How to join two or more datasets with some variable in common

Tydyverse
---------

Tidyverse is a collection of R packages for data science. The packages under the tidyverse umbrella help us in performing and interacting with the data. There are a whole host of things you can do with your data, such as subsetting, transforming, visualizing, etc.
Among all the packages, we will use functions from the following ones:

- **dplyr** provides a grammar of data manipulation.
- **tidyr** provides a set of functions that help you get to tidy data.
- **ggplot2** is a system for declaratively creating graphics, based on The Grammar of Graphics.

Go ahead and install it directly from within RStudio:

.. code-block:: R

    install.packages("tidyverse")


Tibbles instead of data frames
------------------------------

The tidyverse grammar is designed to work with a slightly different data structure called *tibbles*. Tibbles are very similar to data frames, but they tweak some older behaviours to make life a little easier. We can work directly with data frames but at some point they might internally be transformed into a tibble object. So we better know some important differences between tibbles and data frames and how to convert them.

We can convert a data frame into a tibble and a tibble into a data frame:

.. code-block:: R

    library(tidyverse)
    data(swiss)

    swiss_tibble<-as_tibble(swiss)
    swiss_df<-as.data.frame(swiss_tibble)

Tibble don't have row names. We'll learn later how to deal with that. So we missed the row names when converting the data frame into a tibble:

.. code-block:: R

    swiss
    swiss_tibble
    swiss_df

If you want to pull out a single variable from a tibble, you need ``$`` or ``[[``. ``[[`` can extract by name or position; ``$`` only extracts by name but is a little less typing:

.. code-block:: R

    swiss_tibble$Fertility
    swiss_tibble[[1]]
    swiss_tibble[["Fertility"]]



The pipe
--------

First, we'll learn some useful functions from the **dplyr** and **tidyr** packages. One of the greatest advantages of these packages is you can use the pipe function ``%>%`` to combine different functions in R. Let's go and practice by computing the mean for all the variables:

.. code-block:: R

    data(swiss)

    # Basic R notation
    apply(swiss,2,mean)

    # Tidyverse notation (with pipe)
    swiss %>% apply(2,mean)

You can use pipes as many times as you want. They will just get the output of one function and pass it as the input of the next one. Usually you use one function per line so the code is easier to read.
Let's see how we can take the *swiss* dataset, convert it to a tibble while preserving the row names

.. code-block:: R

    data(swiss)

    swiss_tibble<-swiss %>%
      rownames_to_column(var="Province") %>%
      as_tibble()

    swiss_tibble

The interesting functions from the **dplyr** and **tidyr** packages are:

- **arrange()**: Arrange your column data in ascending or descending order
- **select()**: Select columns from your dataset
- **filter()**: Filter out certain rows that meet your criteria(s)
- **mutate()**: Create new columns by preserving the existing variables
- **summarise()**: Summarise any of the above functions
- **group_by()**: Group different observations together such that the original dataset does not change. Only the way it is represented is changed in the form of a list
- **pivot_longer()/pivot_wider()**: Transfor a data frame between a long and wide format.

You can have a look to the Data Wrangling cheatsheet (https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) which is a good one-page summary of the main functions.

Let's see how these work!

Arrange data
------------

For example, we can **arrange** the *swiss* data in ascending or descending order using the variable Fertility:

.. code-block:: R

    # Ascending order
    swiss %>%
      rownames_to_column(var="Province") %>%
        arrange(Fertility)

    # Ascending order
    swiss %>%
      rownames_to_column(var="Province") %>%
      arrange(desc(Fertility))

Select variables
----------------

Let's just **select** variables. Keep the row names (after transforming them to a variable) and the first three variables:

.. code-block:: R

    # Select variable by names
    swiss %>%
      rownames_to_column(var="Province") %>%
      select(Province,Fertility,Agriculture,Examination)

    # Select as start_variable:end_variable
    swiss %>%
      rownames_to_column(var="Province") %>%
      select(Province:Examination)

    # Select by removing variables
    swiss %>%
      rownames_to_column(var="Province") %>%
      select(-Education,-Catholic,-Infant.Mortality)

Filter observations
-------------------

We can also **filter** observations (i.e. rows). Let's keep the Provinces with 1) fertility larger than 80 and 2) fertility larger than 80 and agriculture larger than 40:

.. code-block:: R

    swiss %>%
      rownames_to_column(var="Province") %>%
      filter(Fertility>80)

    swiss %>%
      rownames_to_column(var="Province") %>%
      filter(Fertility>80 & Agriculture>40)

Create new variables
--------------------

We can also create new variables by applying operations to the existing variables with the **mutate()** function. Let's compute a new variable called *Inverse.Fertility* as 100-Fertility:

.. code-block:: R

    swiss %>%
      rownames_to_column(var="Province") %>%
      mutate(Inverse.Fertility=100-Fertility)

Summarise data
--------------

We can also compute summaries of the variables. Let's compute the mean of a single variable with the **summarise()** function:

.. code-block:: R

    swiss %>%
      rownames_to_column(var="Province") %>%
      summarise(mean_Fertility=mean(Fertility))

We can also apply a function to all variables with **summarise_all()**. Let's compute the mean of each variable (i.e. the same as you did with ``apply(data_frame,2,mean)``):

.. code-block:: R

    swiss %>%
      rownames_to_column(var="Province") %>%
      summarise_all(mean)

You will see that the mean of the variable *Province* is, of course NA. If we want to compute the mean only for those variables that fulfill some criterium, you can use **summarise_if()**. Or you can select variables before summarising. We'll compute the mean of all the variables which are numeric:

.. code-block:: R

    swiss %>%
      rownames_to_column(var="Province") %>%
      summarise_if(is.numeric,mean)

    swiss %>%
      rownames_to_column(var="Province") %>%
      select(-Province) %>%
      summarise_all(mean)

Finally, very often you want to compute a summary for groups of observations. You can do that by using the **group_by()** function before summarizing the data. The **group_by()** function is not going to modify the data but the behavior of the next operations.

For this we need a factor grouping our observations. We will load the **iris** dataset, which has information on the sepal and petal of 50 flowers from each of 3 species of iris (*Iris setosa*, *Iris versicolor*, and *Iris virginica*). We are going to compute the mean sepal and petal length and width for each of the 3 species, separately:

.. code-block:: R

    data(iris)

    # Compute the mean for all observations
    iris %>%
      select(-Species) %>%
      summarise_all(mean)

      # Compute the mean for each species by grouping
    iris %>%
      group_by(Species) %>%
      summarise_all(mean)

Pivot data
----------

In some cases we need to change the data structure by collapsing several variables into a single one or splitting one variable into several variables. This is specially painful with base R but very straightforward with *tidyverse*.

Consider the dataset *relig_income* which contains data on a survey about the income range of different people grouped by their religion. The data structure consists on 18 rows (18 religions) and 11 columns (11 income ranges), being the numbers in each cell the number of respondees:

.. code-block:: R

    data(relig_income)
    relig_income

Depending on the downstream analysis we may want to re-structure the data so we keep the same information but with 3 variables:

- religion
- income
- respondees

We can transform the data frame with the function **pivot_longer()**: we'll have to exclude the variable that we don't want to transform (religion) and tell the function the name that the column names and the values are going to take in the new data frame.

.. code-block:: R

    relig_income_long<-relig_income %>%
      pivot_longer(-religion,names_to = "income",values_to = "respondees")

    relig_income_long

The same way, we can back-transform the data with **pivot_wider()**:

.. code-block:: R

    relig_income_long %>%
      pivot_wider(names_from = "income",values_from = "respondees")

Join data
---------

Joining two data frames that have a variable in common is also something that we might need to do. This is very easy to do with the **left_join()** function. Given two data frames, this will append the information in the second data frame to each observation in the first data frame. And this will properly join the data even if the order of the observations is different in the two data frames.

Let's see an example. Consider the datasets *band_members* and *band_instruments*:

.. code-block:: R

    data(band_members)
    data(band_instruments)

    band_members
    band_instruments

If we want to join these two data frames by the common variable *name*, we use **left_join()**:

.. code-block:: R

    band_members %>% left_join(band_instruments)



Exercises
---------

Load the *dune* and *dune.env* datasets from the *vegan* package containing information on dune meadow vegetation. The *dune* data frame contains the cover values for 30 species (30 columns) on 20 sites (20 rows). The *dune.env* data frame contains the corresponding environmental data (5 variables) of each site (20 rows).

* Each site is coded with a number as the row name. Make the row names a variable in both data frames named as *site*.
* Transform the *dune* data frame so it has the same information but a final structure of 3 variables (*site*, *species* and *cover*).
* Build a new data frame by joining the two data frames using the variable they will have in common (*site*).

.. hidden-code-block:: R

    library(vegan)
    data(dune)
    data(dune.env)

    dune<-dune %>%
      rownames_to_column(var="site") %>%
      pivot_longer(-site,names_to = "species",values_to = "cover")
    dune.env<-dune.env %>%
      rownames_to_column(var="site")
    dune.all<-dune %>%
      left_join(dune.env,by="site")

    dune.all
