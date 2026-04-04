# Workflow Orchestration
We are using Kestra to extract the source data, upload it to GCP, and also schedule it for future pulls.

## How-To
1. Make sure Docker is operational on your machine (e.g. Docker engine / Docker Desktop is installed)
2. Open a terminal instance in the root of this `kestra` directory.
3. Create a `.env` file and populate it with the following:
     ```
     SECRET_SERVICE_ACCOUNT_KEY=<your_gcp_service_account_key>
     ```
4. Get Kestra running by running `docker compose up` (this uses the `compose.yaml` file to know what to spin up)
5. Access the Kestra UI by visiting http://localhost:8080
6. Import each of the flows in the `flows` folder, and run them as follows:
     1. Run **01_gcp_kv** to set up key-value store for the namespace
     2. (Optional) Run **02_gcp_setup** if you do not yet have a GCS Bucket and BigQuery dataset. Skip this if you created them in Terraform.
     3. Run **03_table_setup** to create the final table where data will go.
     4. :warning: **READ CAREFULLY!** :warning:  
     **04_data_extract_scheduled** is scheduled to run at the beginning of each quarter. It is not intended to be run manually.  
     However, if you want to run it manually, you can do so with backfills. But you **MUST** follow these conditions:
          - Figure out which quarter of the year you are in (e.g. January - March is Q1, April - June is Q2, ...).
          - Go to the [source data page](https://open.toronto.ca/dataset/development-pipeline/) and check the "Data last refreshed" field
          - If this field has a value in the last quarter, you can collect that data by executing a backfill in a time range including the most recent quarter end (April 1st 00:00:00 for Q1, July 00:00:00 for Q2, November 00:00:00 for Q3, and January 00:00:00 for Q4).
          - If this field has a value for the current quarter, do not backfill as you will end up with bad data. You will have to wait until the quarter ends for this flow to run.
     5. (No action required) **05_data_load** will run automatically once flow 04 completes and will load the temp data into the final table in BigQuery

## Notes
Ideally this would all be configured on an instance of Kestra (e.g. Kestra Cloud) that is perpetually running.  
However, given the additional cost that would incur and since this is a personal project, the free version of Kestra is being used instead and these manual steps are needed.