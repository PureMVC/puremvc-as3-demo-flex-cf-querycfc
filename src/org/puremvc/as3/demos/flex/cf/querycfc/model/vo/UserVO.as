/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc.model.vo
{
	// *** IMPORTANT CASE SENSITIVE ***
	[RemoteClass(alias="Demo_AS3_Flex_CF_QueryCFC.assets.cfc.UserVO")]

	[Bindable]	
	public class UserVO
	{
		public var user_id:Number;
		public var username:String;
		public var password:String;

		public function UserVO(){}
	}
}