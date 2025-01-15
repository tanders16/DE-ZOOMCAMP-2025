# Module 1 Homework: Docker & SQL

**Question 1. Understanding docker first run**

<img width="735" alt="Screenshot 2025-01-14 at 10 51 35 PM" src="https://github.com/user-attachments/assets/2806b221-18d4-4499-a09c-8f7dcaa3dd6c" />

Ran terminal command "docker run -it --entrypoint=bash python:3.12.8"\
In bash, ran "pip --version"\
Result: 24.3.1


**Question 2. Understanding Docker networking and docker-compose**

Answer: db:5432 - Containers in network refer to in network ports


**Question 3. Trip Segmentation Count**

During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:

Up to 1 mile\
In between 1 (exclusive) and 3 miles (inclusive),\
In between 3 (exclusive) and 7 miles (inclusive),\
In between 7 (exclusive) and 10 miles (inclusive),\
Over 10 miles

Answer:  104,802; 198,924; 109,603; 27,678; 35,189

<img width="843" alt="Screenshot 2025-01-14 at 11 32 04 PM" src="https://github.com/user-attachments/assets/9b8876ad-5b09-4773-a2b3-321ed5e2d62f" />


**Question 4. Longest trip for each day**

Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.\
Tip: For every day, we only care about one single trip with the longest distance.\
Answer: 2019-10-31

<img width="835" alt="Screenshot 2025-01-14 at 11 32 52 PM" src="https://github.com/user-attachments/assets/87a6d307-4940-4c01-b9e6-5eb8d13aaf90" />

Alternate query - as don't really need daily aggregation to anser question posed.

<img width="832" alt="Screenshot 2025-01-14 at 11 33 27 PM" src="https://github.com/user-attachments/assets/77337a2a-5131-43a9-bd98-89db3a05a255" />


**Question 5. Three biggest pickup zones**

Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?\
Consider only lpep_pickup_datetime when filtering by date.\
Answer: East Harlem North, East Harlem South, Morningside Heights

<img width="834" alt="Screenshot 2025-01-14 at 11 34 14 PM" src="https://github.com/user-attachments/assets/996e4433-c4a3-456a-ae09-421b790078cb" />


**Question 6. Largest tip**

For the passengers picked up in Ocrober 2019 in the zone name "East Harlem North" which was the drop off zone that had the largest tip?\
Note: it's tip , not trip. We need the name of the zone, not the ID.\
Answer:  JFK Airport

<img width="828" alt="Screenshot 2025-01-14 at 11 35 35 PM" src="https://github.com/user-attachments/assets/17a19061-854a-4d2a-aeae-e07b04712072" />


**Question 7. Terraform Workflow**

Which of the following sequences, respectively, describes the workflow for:\
  1. Downloading the provider plugins and setting up backend,
  2. Generating proposed changes and auto-executing the plan
  3. Remove all resources managed by terraform`

Answer: terraform init, terraform apply -auto-ap**p**rove, terraform destroy\
NOTE: approve is misspelled in the answer selection list (missing one "p").

See work files: [main.tf](main.tf), [variables.tf](variables.tf)

INIT\
<img width="848" alt="Screenshot 2025-01-15 at 1 17 35 AM" src="https://github.com/user-attachments/assets/54f4b716-6ad9-4983-b092-3fcb175239d4" />

APPLY\
<img width="831" alt="Screenshot 2025-01-15 at 1 26 11 AM" src="https://github.com/user-attachments/assets/532aeff5-2c58-443e-be4a-7a64a7e8f109" />
<img width="837" alt="Screenshot 2025-01-15 at 1 26 21 AM" src="https://github.com/user-attachments/assets/0e154b03-4b93-4046-9b3b-7f94e1652638" />

DESTROY\
(forgot to take snapshot)



