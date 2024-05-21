# *Xenopus* tools

This is a collection of tools for labwork with *Xenopus*.

***X. laevis* sgRNA designer**

A complementary tool to CRISPRscan when designing guides for *X. Laevis*. It compares the lists of gRNA's and makes a list of all guides that hit both S & L homeologs. More info in the [user guide](https://docs.google.com/document/d/1v7YCj164-mCf7bTSL-fjmvl6j6hjO1ojWTMvaEw0ZQ0/edit?usp=sharing).

**Temperature vs Development calculators (*X. laevis* & *X. tropicalis*)**

We've collected data on development of *Xenopus* embryos over time at different temperatures in the Lienkamp lab and at the CSHL Xenopus Course '23 (Thanks @Kate McCluskey!). The curves and how I modeled them is explained [here](https://docs.google.com/document/d/1hgQUWO2XMmLkNYLLH7CPkMmxlMuVqj-LPx0SfMHwP9Q/edit?usp=sharing). 

This resulted in an equation with NF-stage, Temperature, and Time as variables. The tools respectively allow you to enter two of the variables and calculate the third.

There are few data points between stages 40-45, which makes the tools fairly inaccurate at these stages. I've also not extensively tested the predictions at stages below 30, I'd be glad to get feedback about the performance there.

**General information**

I first made all of the tools in python, you can find them in the folder *python_files*. The code is much easier to read in those because they aren't embedded in an app.

I then made *shiny* apps in R. If you just want to use the tools, you can directly use them online:

https://xenopus.shinyapps.io/NFstage-temp/

https://xenopus.shinyapps.io/NF-time/

https://xenopus.shinyapps.io/XLaevis_gRNA_designer/

They are currently still hosted on a free server with limited use-time per month. If access ever gets restricted, you can find the same apps in the folder *shiny-apps* and run them locally.
You'll need to install R and RStudio. Then open the files in RStudio and run them by pressing ctr+shift+enter (or by selecting all the code and clicking the *run* button).

