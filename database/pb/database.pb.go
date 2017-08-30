// Code generated by protoc-gen-go. DO NOT EDIT.
// source: database.proto

/*
Package pb is a generated protocol buffer package.

It is generated from these files:
	database.proto

It has these top-level messages:
	NewClassReq
	SessionResp
*/
package pb

import proto "github.com/golang/protobuf/proto"
import fmt "fmt"
import math "math"

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion2 // please upgrade the proto package

type NewClassReq struct {
	ClassName   string `protobuf:"bytes,1,opt,name=className" json:"className,omitempty"`
	Email       string `protobuf:"bytes,2,opt,name=email" json:"email,omitempty"`
	Password    string `protobuf:"bytes,3,opt,name=password" json:"password,omitempty"`
	SessionGUID string `protobuf:"bytes,4,opt,name=sessionGUID" json:"sessionGUID,omitempty"`
}

func (m *NewClassReq) Reset()                    { *m = NewClassReq{} }
func (m *NewClassReq) String() string            { return proto.CompactTextString(m) }
func (*NewClassReq) ProtoMessage()               {}
func (*NewClassReq) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{0} }

func (m *NewClassReq) GetClassName() string {
	if m != nil {
		return m.ClassName
	}
	return ""
}

func (m *NewClassReq) GetEmail() string {
	if m != nil {
		return m.Email
	}
	return ""
}

func (m *NewClassReq) GetPassword() string {
	if m != nil {
		return m.Password
	}
	return ""
}

func (m *NewClassReq) GetSessionGUID() string {
	if m != nil {
		return m.SessionGUID
	}
	return ""
}

type SessionResp struct {
	SessionGUID string `protobuf:"bytes,1,opt,name=sessionGUID" json:"sessionGUID,omitempty"`
	Success     bool   `protobuf:"varint,2,opt,name=success" json:"success,omitempty"`
	Message     string `protobuf:"bytes,3,opt,name=message" json:"message,omitempty"`
}

func (m *SessionResp) Reset()                    { *m = SessionResp{} }
func (m *SessionResp) String() string            { return proto.CompactTextString(m) }
func (*SessionResp) ProtoMessage()               {}
func (*SessionResp) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{1} }

func (m *SessionResp) GetSessionGUID() string {
	if m != nil {
		return m.SessionGUID
	}
	return ""
}

func (m *SessionResp) GetSuccess() bool {
	if m != nil {
		return m.Success
	}
	return false
}

func (m *SessionResp) GetMessage() string {
	if m != nil {
		return m.Message
	}
	return ""
}

func init() {
	proto.RegisterType((*NewClassReq)(nil), "pb.NewClassReq")
	proto.RegisterType((*SessionResp)(nil), "pb.SessionResp")
}

func init() { proto.RegisterFile("database.proto", fileDescriptor0) }

var fileDescriptor0 = []byte{
	// 183 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0xe2, 0xe2, 0x4b, 0x49, 0x2c, 0x49,
	0x4c, 0x4a, 0x2c, 0x4e, 0xd5, 0x2b, 0x28, 0xca, 0x2f, 0xc9, 0x17, 0x62, 0x2a, 0x48, 0x52, 0xaa,
	0xe7, 0xe2, 0xf6, 0x4b, 0x2d, 0x77, 0xce, 0x49, 0x2c, 0x2e, 0x0e, 0x4a, 0x2d, 0x14, 0x92, 0xe1,
	0xe2, 0x4c, 0x06, 0xb1, 0xfd, 0x12, 0x73, 0x53, 0x25, 0x18, 0x15, 0x18, 0x35, 0x38, 0x83, 0x10,
	0x02, 0x42, 0x22, 0x5c, 0xac, 0xa9, 0xb9, 0x89, 0x99, 0x39, 0x12, 0x4c, 0x60, 0x19, 0x08, 0x47,
	0x48, 0x8a, 0x8b, 0xa3, 0x20, 0xb1, 0xb8, 0xb8, 0x3c, 0xbf, 0x28, 0x45, 0x82, 0x19, 0x2c, 0x01,
	0xe7, 0x0b, 0x29, 0x70, 0x71, 0x17, 0xa7, 0x16, 0x17, 0x67, 0xe6, 0xe7, 0xb9, 0x87, 0x7a, 0xba,
	0x48, 0xb0, 0x80, 0xa5, 0x91, 0x85, 0x94, 0x92, 0xb9, 0xb8, 0x83, 0x21, 0xdc, 0xa0, 0xd4, 0xe2,
	0x02, 0x74, 0x0d, 0x8c, 0x18, 0x1a, 0x84, 0x24, 0xb8, 0xd8, 0x8b, 0x4b, 0x93, 0x93, 0x53, 0x8b,
	0x8b, 0xc1, 0xce, 0xe0, 0x08, 0x82, 0x71, 0x41, 0x32, 0xb9, 0xa9, 0xc5, 0xc5, 0x89, 0xe9, 0xa9,
	0x50, 0x77, 0xc0, 0xb8, 0x49, 0x6c, 0x60, 0x0f, 0x1b, 0x03, 0x02, 0x00, 0x00, 0xff, 0xff, 0x95,
	0x9e, 0x5d, 0x5e, 0x02, 0x01, 0x00, 0x00,
}
