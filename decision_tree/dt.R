# 拟合树模型主要使用软件包rpart和tree
# datasource: https://github.com/andrewgbruce/statistics-for-data-scientists.git 


library(rpart)


PSDS_PATH <- file.path('~', 'statistics-for-data-scientists')

loan_data <- read.csv(file.path(PSDS_PATH, 'data', 'loan_data.csv'))
loan_data <- select(loan_data, -X, -status)

outcome <- loan_data[-1, 1]

borrow_knn <- knn(borrow_df, test=borrow_df, cl=loan_data[, 'outcome'], prob=TRUE, k=20)
loan_data$borrower_score <- borrow_feature

loan_tree <- rpart(outcome ~ borrower_score + payment_inc_ratio,
                    data=loan_data, control = rpart.control(cp=.005))
plot(loan_tree, uniform=TRUE, margin=.05)
text(loan_tree)
