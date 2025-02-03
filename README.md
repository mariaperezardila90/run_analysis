# Run Analysis
This repository contains an R script that processes and cleans the **Human Activity Recognition Using Smartphones** dataset from the UCI Machine Learning Repository. The goal is to create a tidy dataset with the average of each variable for each activity and subject.


# Files in This Repository
- **`run_analysis.R`**: The R script that performs data cleaning and transformation.
- **`tidy_data.txt`**: The final tidy dataset containing the average of each measurement for each activity and each subject.
- **`README.md`**: This file, which explains how the script works and includes the codebook describing the dataset variables.


# How the Script Works
The script follows these steps:

1. **Download and Unzip the Dataset**  
   The dataset is downloaded from the UCI Machine Learning Repository and extracted to the working directory.

2. **Load Features and Activity Labels**  
   - `features.txt` provides the variable names.
   - `activity_labels.txt` maps activity IDs to descriptive activity names.

3. **Load Training and Test Data**  
   The script reads the training and test sets:
   - `X_train.txt` and `X_test.txt`: Feature measurements.
   - `y_train.txt` and `y_test.txt`: Activity labels.
   - `subject_train.txt` and `subject_test.txt`: Subject IDs.

4. **Merge Training and Test Sets**  
   The datasets are combined into one dataset using `rbind()`.

5. **Extract Mean and Standard Deviation Measurements**  
   Only the measurements on the mean and standard deviation are extracted using `grep()`.

6. **Apply Descriptive Activity Names**  
   The numeric activity labels are replaced with descriptive activity names (`WALKING`, `SITTING`, etc.).

7. **Label the Dataset with Descriptive Variable Names**  
   Variable names are made more descriptive by:
   - Replacing prefixes `t` and `f` with `TimeDomain_` and `FrequencyDomain_`.
   - Expanding abbreviations like `Acc` to `Accelerometer` and `Gyro` to `Gyroscope`.
   - Removing symbols and formatting names clearly.

8. **Create a Tidy Dataset**  
   The dataset is grouped by `Subject` and `ActivityLabel`, and the mean of each variable is calculated using `dplyr`.

9. **Save the Tidy Dataset**  
   The final tidy dataset is saved to `tidy_data.txt`.


## Codebook: Description of Variables
The tidy dataset (`tidy_data.txt`) includes the following variables:

1. **`Subject`**:  
   - Identifier for the person who performed the activity (range: 1 to 30).

2. **`ActivityLabel`**:  
   - Descriptive name of the activity performed (e.g., `WALKING`, `SITTING`, `LAYING`, etc.).

3. **Measurement Variables**:  
   These variables represent the average of each sensor measurement for each subject and activity. Examples include:

   - **`TimeDomain_BodyAccelerometer_Mean_X`**: Mean of body acceleration in the X-axis (time domain).
   - **`TimeDomain_BodyAccelerometer_StandardDeviation_Y`**: Standard deviation of body acceleration in the Y-axis (time domain).
   - **`FrequencyDomain_BodyGyroscope_Mean_Z`**: Mean of body gyroscope readings in the Z-axis (frequency domain).
   - **`TimeDomain_BodyAccelerometerJerk_Magnitude_StandardDeviation`**: Standard deviation of the magnitude of jerk signals from the body accelerometer (time domain).


## How to Run the Script
1. **Clone the Repository**  
   ```bash
   git clone https://github.com/mariaperezardila90/run_analysis
