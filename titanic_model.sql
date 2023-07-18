--Building a regression model to predict survival on the Titanic using SQL

-- query from table
SELECT *
FROM `project-binh-2023-demo.DA04.train_titanic`
LIMIT 10;


--create logistic regression model
CREATE OR REPLACE MODEL `DA04.titanic_logistic_model`
OPTIONS( model_type = 'LOGISTIC_REG',
       auto_class_weights= TRUE,
       input_label_cols= ['Survived']
     ) AS
SELECT 
   Pclass, Sex, Age, SibSp, Fare, Embarked, Survived
FROM
   `project-binh-2023-demo.DA04.train_titanic`;

-----------
SELECT
*
FROM
ML.EVALUATE( MODEL `DA04.titanic_logistic_model`);
SELECT
*
FROM
ML.CONFUSION_MATRIX(MODEL `DA04.titanic_logistic_model`);
SELECT
*
FROM
ML.ROC_CURVE(MODEL `DA04.titanic_logistic_model`);

--OR #standardSQL
SELECT
*
FROM
 ML.EVALUATE( `DA04.titanic_logistic_model`,(
 SELECT Survived,Pclass, Sex, Age, SibSp, Fare, Embarked,Parch
 FROM `project-binh-2023-demo.DA04.train_titanic`
 ));
-- create new predict for test_data 
 SELECT
*
 FROM ML.PREDICT(MODEL `DA04.titanic_logistic_model`,
 (
  SELECT Pclass, Sex, Age, SibSp, Fare, Embarked,Parch
  FROM `project-binh-2023-demo.DA04.test_titanic`
  WHERE Age > 0 and Fare >0
 ))