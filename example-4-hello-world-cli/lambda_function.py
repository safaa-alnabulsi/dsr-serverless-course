
def lambda_handler(event, context):
	print('inside the lambda function cli')
	print("value1 = ",  event['key1'])
	write_my_name('Nina')
	return event['key1']

def write_my_name(name):
	print("Hello from inside write_by_name function", name)