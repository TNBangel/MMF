# Compute Accuracy, Precision, Recall, F-score, Kappa, 
# Specificity and True Skill Statistic
# (for a given confusion matrix)

# Author : Gw�na�E Leday
# Date   : October 2009


compute.indexes <- function(conf){

	## Error handling
	if((dim(conf)[1]!=2) | (dim(conf)[2]!=2)){
		stop("The confusion matrix must have two rows and two columns")
	} 
	if(is.matrix(conf)==FALSE){
		stop("The parameter must be a matrix")
	}

	## Initialization
	TP <- conf[1,1]
	FN <- conf[1,2]
	FP <- conf[2,1]
	TN <- conf[2,2]
	R1 <- TP + FN
	R2 <- FP + TN
	C1 <- TP + FP
	C2 <- FN + TN
	total <- sum(conf)

	## Calculation
	# Accuracy
	A <- (TP+TN)/total
	# Precision
	P <- TP/(TP+FP)
	# Recall
	R <- TP/(TP+FN)
	# F-score
	F <- (2*P*R)/(P+R)
	# Kappa
	EA <- (((C1*R1)/total)/total)+(((C2*R2)/total)/total)
	K <- (A-EA)/(1-EA)
	# Specificity
	S <- TN/(FP+TN)
	# True Skill Statistic
	TSS <- S + R - 1

	## Output
	out <- t(as.matrix(c(A,P,R,F,K,S,TSS),1,7))
	colnames(out) <- c("Accuracy","Precision","Recall","F-score","Kappa","Specificity", "TSS")
	rownames(out) <- "Value"
	return(out)
}
