/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc.model
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.demos.flex.cf.querycfc.model.vo.UserVO;
	
	public class RemoteDelegate
	{
		private var responder:IResponder;
		private var ro:RemoteObject;
		
		public function RemoteDelegate( responder:IResponder, url:String ) 
		{
			ro = new RemoteObject();
			ro.destination = "ColdFusion";
			ro.source = url;
			
			// and store a reference to the proxy that created this delegate
			this.responder = responder;
		}
		
		public function getAll():void
		{
			// Call the service
			var token:AsyncToken = ro.getAllUsers.send();
			// Notify this responder when the service call completes
			token.addResponder( this.responder );
		}

		public function callCFC( method:String, item:UserVO ):void 
		{
			// Call the service
			var token:AsyncToken = ro[method].send( item );
			// Notify this responder when the service call completes
			token.addResponder( this.responder );
		}
	}
}