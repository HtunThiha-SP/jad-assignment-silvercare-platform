package com.silvercare.util;

public class OperationResponse {
	private boolean success;
	private String message;
	private String code;
	private Object responseData;

	public OperationResponse(boolean success, String message, String code, Object responseData) {
		this.success = success;
		this.message = message;
		this.code = code;
		this.responseData = responseData;
	}

	public OperationResponse(boolean success, String message, String code) {
		this.success = success;
		this.message = message;
		this.code = code;
		this.responseData = null;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Object getResponseData() {
		return responseData;
	}

	public void setResponseData(Object responseData) {
		this.responseData = responseData;
	}
}