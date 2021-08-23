from mymodel import predict

def lambda_handler(event, context):
	print('inside the lambda function')
	print("value1 = ",  event['key1'])
	return event['key1']

# 	print('inside the lambda function')
# 	print("sentence = ",  event['sentence'])
# 	sentence = event['sentence']
# 	print(predict(sentence))
# 	return predict(sentence)



