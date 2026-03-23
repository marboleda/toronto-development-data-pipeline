# Toronto Development Data Pipeline
This is a data pipeline for processing Toronto's site development data (for residential and non-residential sites). This is my project for the [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main) 2026 cohort.

## Overview
The City of Toronto provides public data through its [Open Data Portal](https://open.toronto.ca/). It provides various datasets relating to Development & Infrastructure, in particular the [Development Pipeline](https://open.toronto.ca/dataset/development-pipeline/) data which shows different site development projects (residential, non-residential, and mixed-use).

By processing & analysing this data, it can gives us insight and trends relating to development in the City of Toronto.

## Use Cases
* Can answer questions relating to housing supply 
  * How much new housing supply was made available in the last quarter? The last year? The last 5 years?
  * How much housing supply will be made available in the next year?
  * etc.



## Architecture
| Technology | Purpose |
|---|---|
| Terraform | Infrastructure Provisioning |
| Google Cloud Storage | Data Lake |
| Google Big Query | Data Warehouse |
| Looker | Data Visualization (Dashboards) |

We will be using **batch** processing for this project.  
The Development Pipeline source data is refreshed Quarterly, and site development in general takes time. So there's no need for a real-time stream processing.

## Dashboard

## Potential Improvements for the Future
