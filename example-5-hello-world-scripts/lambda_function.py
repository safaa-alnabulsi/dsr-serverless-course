
def lambda_handler(event, context):
	print('inside the lambda function')
	print("value1 = ",  event['key1'])
	print('updated lambda from shell script')
	print(my_sum(1, 2))
	return event['key1']

def my_sum(a,b):
	return a + b