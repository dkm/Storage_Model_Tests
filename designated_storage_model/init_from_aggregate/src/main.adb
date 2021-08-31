with Ada.Unchecked_Deallocation;

with Logging_Storage_Models; use Logging_Storage_Models;
with Test_Support; use Test_Support;

procedure Main is
   type Device_Array_Access is access all Integer_Array
      with Designated_Storage_Model => Logging_Storage_Models.Model;

   procedure Free is new Ada.Unchecked_Deallocation
      (Integer_Array, Device_Array_Access);

   Device_Array : Device_Array_Access;
begin
   Device_Array := new Integer_Array'(1 .. 10 => 999);

   pragma Assert (Model.Count_Read = 0);
   Host_Array.all := Device_Array.all;
   pragma Assert (Model.Count_Read = 1);

   pragma Assert (Host_Array (1 .. 10) = (1 .. 10 => 999));
end;
