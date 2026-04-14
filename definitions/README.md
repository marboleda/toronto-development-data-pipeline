# Transformations
We are using **Dataform** as our transformation system due to its easy integration with BigQuery and the GCP ecosystem (with it being a tool within GCP).

## How-To
Dataform requires its own repo. However, to avoid having multiple repos for this project, the transformation files will be contained here within this **definitions** folder.  

To run these, you will need to create your own Dataform project in your GCP instance and place these files into your definitions folder.

Make sure to replace the values in **sources/bq_development_pipeline.sqlx** with the relevant ones for your project.

