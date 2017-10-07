## Input Data
Observations was divided into the following files:
- cacluations and observations data
    - x_train.txt
    - x_test.txt
- Activity data identify the activity of every row in the x data
    - y_train.txt
    - y_test.txt
- Subject Data identify the subject of every row in the x data
    - subject_train.txt
    - subject_test.txt
## Variables
* `xdata` for holding x_train.txt and x_test.txt using `rbind`.
* `ydata` for holding **y_train.txt** and **y_test.txt**  using `rbind`.
* `subject` for holding **subject_train.txt** and **subject_test.txt** using `rbind`.
* `features` for holding the nams of the columns of x dataset  form **features.txt** file.
* `activity_labels` for holding acitivity names from **activity_labels.txt** file.
## Transformations
* First reading the data from the files then combining the train and test data sets together using `rbind`
* labelinge the columns in the variable `xdata` using features variable then extracting the features of **mean** and **std** only using `grep` function.
* replacing the rows in `ydata` variable with understandable activity name using `feature` variable.
* then all data is compined together in `all_data` variable.
* finally the data is aggregated grouped by subject and activity using `melt` and `dcast` funcitons, then it is written to a file.

