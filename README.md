# Toronto Development Data Pipeline
This is a data pipeline for processing Toronto's site development data (for residential and non-residential sites). This is my project for the [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main) 2026 cohort.

## Overview
The City of Toronto provides public data through its [Open Data Portal](https://open.toronto.ca/). It provides various datasets relating to Development & Infrastructure, in particular the [Development Pipeline](https://open.toronto.ca/dataset/development-pipeline/) data which shows different site development projects (residential, non-residential, and mixed-use).

By processing & analysing this data, it can gives us insight and trends relating to development in the City of Toronto.

## Use Cases
* Answer questions relating to Toronto housing supply 
  * How much new housing supply was made available in the last quarter? The last year? The last 5 years?
  * How much housing supply will be made available in the next year?
  * etc.
* Identify outliers
  * Which projects are taking an unusually long time to complete, despite the application being received?
* Comparisons between residential vs. non-residential


## Architecture
| Technology | Purpose |
|---|---|
| Terraform | Infrastructure Provisioning |
| Kestra | Workflow Orchestration |
| Google Cloud Storage | Data Lake |
| Google Big Query | Data Warehouse |
| Dataform | Transformations |
| Looker | Data Visualization (Dashboards) |

We will be using **batch** processing for this project.  
The Development Pipeline source data is refreshed Quarterly, and site development in general takes time. So there's no need for a real-time stream processing.

## Dashboard
The dashboard was created using Looker Studio and can be found [here](https://lookerstudio.google.com/reporting/68066784-7aac-4c0f-97a6-18b83965f9c2).

<img width="600" height="638" alt="image" src="https://github.com/user-attachments/assets/f9ba9c17-8d28-4b53-ac12-ffeb6b942764" />


## Notes & Potential Improvements
- The source data does not have a well-defined data dictionary yet, so we need to infer or make assumptions. In a real-world scenario, we should verify with the source data provider about the fields and how they operate (e.g. uniqueness of `Application Number`, whether it ever changes, whether we can be sure that `_id` corresponds to the same application between each data refresh, etc.). We also don't know what units some data points are in.  

- Source data does not have info that could be useful
  - E.g. We have the date when the application was received. But for projects that have already been Built, we do not have a "completion date" field

- We could get more insights the more data we have. However, since we only have access to one copy of the source data and it only gets updated quarterly, this will require time. We do not have access to historical records of the source data (e.g. the state of the source data two quarters ago , last year, etc.)

- Add some testing and quality assurance (e.g. in Dataform)
