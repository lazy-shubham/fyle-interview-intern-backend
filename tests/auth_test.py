import json

def test_no_principal_headers(client):
	response = client.get('/principal/assignments')
	assert response.status_code == 401

def test_incorrect_headers(client):
	response = client.get('/principal/teachers', headers={
		"X-Principal": json.dumps({
			"user_id": 3, "teacher_id": 1
		})
	})
	assert response.status_code == 403
