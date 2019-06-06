with Ada.Text_IO;      use Ada.Text_IO;
with Test_Assertions;  use Test_Assertions;
with P3_1;         use P3_1;

procedure Test_P3_1 is
   Global_Vector : Vector := (2,4,-5,9,1);

   procedure Test_1 is
      Msg   : constant String := "Test_1: Compare two equal strings";
   begin
      Assert_True (Compare_To ("Programming III", "Programming III"), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_1;

   procedure Test_2 is
      Msg   : constant String := "Test_2: Compare two non equal strings";
   begin
      Assert_False (Compare_To ("SPARK 2015", "SPARK 2014"), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_2;

   procedure Test_3 is
      Msg   : constant String := "Test_3: Count Lower Elements I";
   begin
      Assert_True(Count_Lower_Elements((1, 6), 5)=1, Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_3;

   procedure Test_4 is
      Msg   : constant String := "Test_4: Count Lower Elements II";
   begin
      Assert_True(Count_Lower_Elements((100,200), 50)=0, Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_4;

   procedure Test_5 is
      Msg   : constant String := "Test_5: Count Lower Elements III";
   begin
      Assert_True(Count_Lower_Elements((100,200, 2511, 210), 200)=1, Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_5;

   procedure Test_6 is
      Msg   : constant String := "Test_6: Delete Elements I";
   begin
      Assert_True(Delete_Elements((101,-5,10,200),100)=(-5,10), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_6;

   procedure Test_7 is
      Msg   : constant String := "Test_7: Delete Elements II";
   begin
      Assert_True(Delete_Elements((50,147),100)=(1 => 50), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_7;

   procedure Test_8 is
      Msg   : constant String := "Test_8: Delete Elements III";
   begin
      Assert_True(Delete_Elements((1652,1000),999)=(1 => 0), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_8;

   procedure Test_17 is
      Msg   : constant String := "Test_17: Get_Bood_Pressure_Degree I";
   begin
      Assert_True(Get_Bood_Pressure_Degree(85,72)="Normal", Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_17;

   procedure Test_18 is
      Msg   : constant String := "Test_18: Get_Bood_Pressure_Degree II";
   begin
      Assert_True(Get_Bood_Pressure_Degree(136,72)="Prehypertension", Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_18;

   procedure Test_19 is
      Msg   : constant String := "Test_19: Multiply Global Vector I";
   begin
      multiply_global_vector((1,2,3));
      Assert_True(GlobalVector=(1,4,9,-1,-2,-3), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_19;

   procedure Test_20 is
      Msg   : constant String := "Test_20: Multiply Global Vector II";
   begin
      multiply_global_vector((-1,-2,-3,-8,5,10));
      Assert_True(GlobalVector=(-1,-8,-27,8,-10,-30), Msg);
   exception
      when Assertion_Error =>
         Put_Line (Msg & " Failed (assertion)");
      when others =>
         Put_Line (Msg & " Failed (exception)");
   end Test_20;

begin
   Put_Line ("********* Batch Tests *********");
   Test_1;
   Test_2;
   Test_3;
   Test_4;
   Test_5;
   Test_6;
   Test_7;
   Test_8;
   Test_17;
   Test_18;
   Test_19;
   Test_20;
end Test_P3_1;
