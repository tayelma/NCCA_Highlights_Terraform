# NCCA Highlights Terraform Project

This project automates the deployment of AWS resources and processes video content using AWS MediaConvert. It combines Terraform configurations for infrastructure provisioning with Python scripts for video processing.

## Project Structure

- **terraform-AWS-project/**: Contains Terraform configurations for AWS resource provisioning.
- **.gitignore**: Specifies files and directories to be ignored by Git.
- **Dockerfile**: Defines a Docker image for the project environment.
- **config.py**: Configuration settings for the Python scripts.
- **fetch.py**: Script to retrieve video content from specified sources.
- **mediaconvert_process.py**: Handles video processing using AWS MediaConvert.
- **process_one_video.py**: Processes a single video file.
- **requirements.txt**: Lists Python dependencies for the project.
- **run_all.py**: Orchestrates the execution of all scripts.

## Getting Started

### Prerequisites

- **AWS Account**: Required for deploying resources and using AWS MediaConvert.
- **Terraform**: Install from [terraform.io](https://www.terraform.io/downloads.html).
- **Docker**: Install from [docker.com](https://www.docker.com/get-started).
- **Python 3.x**: Install from [python.org](https://www.python.org/downloads/).

### Setup Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/tayelma/NCCA_Highlights_Terraform.git
   cd NCCA_Highlights_Terraform
   ```

2. **Configure AWS Credentials**:

   Ensure your AWS credentials are set up, typically in `~/.aws/credentials`.

3. **Provision AWS Resources with Terraform**:

   ```bash
   cd terraform-AWS-project
   terraform init
   terraform apply
   ```

4. **Build and Run the Docker Container**:

   ```bash
   docker build -t ncca-highlights .
   docker run -v $(pwd):/app -it ncca-highlights
   ```

5. **Install Python Dependencies** (if not using Docker):

   ```bash
   pip install -r requirements.txt
   ```

6. **Execute the Main Script**:

   ```bash
   python run_all.py
   ```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

