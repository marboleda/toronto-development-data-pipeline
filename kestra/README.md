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
6. Import each of the flows in the `flows` folder, and run them in order (you can skip `02_gcp_setup` if you already completed the Terraform steps)

## Notes
Ideally this would all be configured on an instance of Kestra (e.g. Kestra Cloud) that is perpetually running.  
However, given the additional cost that would incur and since this is a personal project, the free version of Kestra is being used instead and these manual steps are needed.