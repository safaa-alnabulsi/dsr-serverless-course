import boto3
import os

BUCKET_NAME='polly-audio-bucket'

def lambda_handler(event, context):
	client = boto3.client('polly')
	response = client.synthesize_speech(VoiceId='Joanna',
										OutputFormat='mp3',
										Text = 'This is a sample text to be synthesized.')

	create_audio_file(response, 'speech.mp3')

	file_url = store_file_in_s3(BUCKET_NAME, 'speech.mp3')
	print(file_url)

def create_audio_file(response, filename):
	file = open('/tmp/' + filename, 'wb')
	file.write(response['AudioStream'].read())
	file.close

def store_file_in_s3(bucket_name, filename):
	s3_client = boto3.client('s3')
	s3_client.upload_file('/tmp/' + filename, bucket_name, filename)
	s3_client.put_object_acl(ACL='public-read', Bucket=bucket_name, Key= filename)
	location = s3_client.get_bucket_location(Bucket=bucket_name)
	region = location['LocationConstraint']

	if region is None:
		url_begining = "https://s3.amazonaws.com/"
	else:
		url_begining = "https://s3-" + str(region) + ".amazonaws.com/"

	file_url = url_begining + bucket_name + "/"  + filename

	return file_url