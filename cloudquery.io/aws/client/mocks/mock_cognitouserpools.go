// Code generated by MockGen. DO NOT EDIT.
// Source: github.com/cloudquery/cloudquery/plugins/source/aws/client (interfaces: CognitoUserPoolsClient)

// Package mocks is a generated GoMock package.
package mocks

import (
	context "context"
	reflect "reflect"

	cognitoidentityprovider "github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	gomock "github.com/golang/mock/gomock"
)

// MockCognitoUserPoolsClient is a mock of CognitoUserPoolsClient interface.
type MockCognitoUserPoolsClient struct {
	ctrl     *gomock.Controller
	recorder *MockCognitoUserPoolsClientMockRecorder
}

// MockCognitoUserPoolsClientMockRecorder is the mock recorder for MockCognitoUserPoolsClient.
type MockCognitoUserPoolsClientMockRecorder struct {
	mock *MockCognitoUserPoolsClient
}

// NewMockCognitoUserPoolsClient creates a new mock instance.
func NewMockCognitoUserPoolsClient(ctrl *gomock.Controller) *MockCognitoUserPoolsClient {
	mock := &MockCognitoUserPoolsClient{ctrl: ctrl}
	mock.recorder = &MockCognitoUserPoolsClientMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockCognitoUserPoolsClient) EXPECT() *MockCognitoUserPoolsClientMockRecorder {
	return m.recorder
}

// DescribeIdentityProvider mocks base method.
func (m *MockCognitoUserPoolsClient) DescribeIdentityProvider(arg0 context.Context, arg1 *cognitoidentityprovider.DescribeIdentityProviderInput, arg2 ...func(*cognitoidentityprovider.Options)) (*cognitoidentityprovider.DescribeIdentityProviderOutput, error) {
	m.ctrl.T.Helper()
	varargs := []interface{}{arg0, arg1}
	for _, a := range arg2 {
		varargs = append(varargs, a)
	}
	ret := m.ctrl.Call(m, "DescribeIdentityProvider", varargs...)
	ret0, _ := ret[0].(*cognitoidentityprovider.DescribeIdentityProviderOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// DescribeIdentityProvider indicates an expected call of DescribeIdentityProvider.
func (mr *MockCognitoUserPoolsClientMockRecorder) DescribeIdentityProvider(arg0, arg1 interface{}, arg2 ...interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	varargs := append([]interface{}{arg0, arg1}, arg2...)
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "DescribeIdentityProvider", reflect.TypeOf((*MockCognitoUserPoolsClient)(nil).DescribeIdentityProvider), varargs...)
}

// DescribeUserPool mocks base method.
func (m *MockCognitoUserPoolsClient) DescribeUserPool(arg0 context.Context, arg1 *cognitoidentityprovider.DescribeUserPoolInput, arg2 ...func(*cognitoidentityprovider.Options)) (*cognitoidentityprovider.DescribeUserPoolOutput, error) {
	m.ctrl.T.Helper()
	varargs := []interface{}{arg0, arg1}
	for _, a := range arg2 {
		varargs = append(varargs, a)
	}
	ret := m.ctrl.Call(m, "DescribeUserPool", varargs...)
	ret0, _ := ret[0].(*cognitoidentityprovider.DescribeUserPoolOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// DescribeUserPool indicates an expected call of DescribeUserPool.
func (mr *MockCognitoUserPoolsClientMockRecorder) DescribeUserPool(arg0, arg1 interface{}, arg2 ...interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	varargs := append([]interface{}{arg0, arg1}, arg2...)
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "DescribeUserPool", reflect.TypeOf((*MockCognitoUserPoolsClient)(nil).DescribeUserPool), varargs...)
}

// ListIdentityProviders mocks base method.
func (m *MockCognitoUserPoolsClient) ListIdentityProviders(arg0 context.Context, arg1 *cognitoidentityprovider.ListIdentityProvidersInput, arg2 ...func(*cognitoidentityprovider.Options)) (*cognitoidentityprovider.ListIdentityProvidersOutput, error) {
	m.ctrl.T.Helper()
	varargs := []interface{}{arg0, arg1}
	for _, a := range arg2 {
		varargs = append(varargs, a)
	}
	ret := m.ctrl.Call(m, "ListIdentityProviders", varargs...)
	ret0, _ := ret[0].(*cognitoidentityprovider.ListIdentityProvidersOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// ListIdentityProviders indicates an expected call of ListIdentityProviders.
func (mr *MockCognitoUserPoolsClientMockRecorder) ListIdentityProviders(arg0, arg1 interface{}, arg2 ...interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	varargs := append([]interface{}{arg0, arg1}, arg2...)
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ListIdentityProviders", reflect.TypeOf((*MockCognitoUserPoolsClient)(nil).ListIdentityProviders), varargs...)
}

// ListUserPools mocks base method.
func (m *MockCognitoUserPoolsClient) ListUserPools(arg0 context.Context, arg1 *cognitoidentityprovider.ListUserPoolsInput, arg2 ...func(*cognitoidentityprovider.Options)) (*cognitoidentityprovider.ListUserPoolsOutput, error) {
	m.ctrl.T.Helper()
	varargs := []interface{}{arg0, arg1}
	for _, a := range arg2 {
		varargs = append(varargs, a)
	}
	ret := m.ctrl.Call(m, "ListUserPools", varargs...)
	ret0, _ := ret[0].(*cognitoidentityprovider.ListUserPoolsOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// ListUserPools indicates an expected call of ListUserPools.
func (mr *MockCognitoUserPoolsClientMockRecorder) ListUserPools(arg0, arg1 interface{}, arg2 ...interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	varargs := append([]interface{}{arg0, arg1}, arg2...)
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ListUserPools", reflect.TypeOf((*MockCognitoUserPoolsClient)(nil).ListUserPools), varargs...)
}
