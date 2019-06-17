with P3_1; use P3_1;
with Ada.Text_IO; use Ada.Text_IO; 
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; 
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body P3_1 with SPARK_Mode => On is
   
   -- Procedures
   
--     procedure Is_Palindrome (number: in out Integer; palindrome: out Boolean) is
--        r: Integer := 0;
--        sum: Integer := 0;
--        temp : Integer := number;
--     begin
--        while number>0 loop
--           r := number mod 10;
--           sum := (sum*10)+r;
--           number := number/10;
--        end loop;
--        
--        if temp = sum then
--           palindrome := True;
--        else 
--           palindrome := False;
--        end if;
--        
--     end Is_Palindrome;
--     
--     procedure Search_And_Increment (number: Integer) is
--        i : Integer := 0;
--     begin
--        while i <= Global_Vector'Length-1 loop
--           if Global_Vector(i) = number then
--              Global_Vector(i) := number + Increment;
--              Increment := Increment + number;
--           end if;
--           i := i +1;
--        end loop;
--     end Search_And_Increment;
--     
--     procedure Resolve_Quadratic_Equation (A, B, C : Float;  R1, R2  : out Float) is
--        Z: Float := B * B - 4.0 * A * C;
--     begin
--        if Z < 0.0 or A = 0.0 then
--           R1 := -1.0;
--           R2 := -1.0;
--           return;
--        else
--           R1 := (-B + SQRT (Z)) / (2.0*A); -- Positive root
--           R2 := (-B - SQRT (Z)) / (2.0*A); -- Negative root
--        end if;
--     end Resolve_Quadratic_Equation;
--     
--     
--     procedure Inverse_Vector is 
--        i : Integer := 0;
--        j : Integer := Global_Inverse_Vector'Length-1;
--        temp: Integer;
--     begin
--        while i < j loop
--           temp := Global_Inverse_Vector(i);
--           Global_Inverse_Vector(i) := Global_Inverse_Vector(j);
--           Global_Inverse_Vector(j) := temp;
--           i := i + 1;
--           j := j - 1;
--        end loop;
--     end Inverse_Vector;
--     
--     procedure Multiply_Vectors (vec1, vec2 : Vector) is
--        count : Integer := Get_Max_Count(vec1,vec2);
--     begin
--        for i in 0..count-1 loop
--           --pragma Loop_Invariant (i in 0..count-1);
--           --pragma Loop_Invariant (for all K in 0..i =>(Global_Vector(K) = vec1(K)*vec2(K)*Global_Vector(K)));
--           Global_Vector(i) := vec1(i)*vec2(i)*Global_Vector(i);
--        end loop;
--     end Multiply_Vectors;
   
   
   -- Functions
   
   function Get_Max_Count (vec1, vec2: Vector) return Integer is
   begin
      if vec1'Length < vec2'Length then
         return vec1'Length;
      end if;
      return vec2'Length;
   end Get_Max_Count;
   
   function Get_Bood_Pressure_Degree (systolic, diastolic: Integer) return String is
   begin
      if systolic < 80 or diastolic < 60 then
         return "Hypotension";
      elsif systolic > 80 and systolic < 120 and diastolic > 60 and diastolic < 80 then
         return "Normal";
      elsif (systolic > 120 and systolic < 139) or (diastolic > 80 and diastolic < 89) then
         return "Prehypertension";
      elsif (systolic > 140 and systolic < 159) or (diastolic > 90 and diastolic < 99) then
         return "Hypertension grade 1";
      elsif systolic > 160 or diastolic > 100 then
         return "Hypertension grade 2";
      elsif systolic > 180 or diastolic > 110 then
         return "Hypertensive crisis (medical emergency)";
      end if;
      return "Error";
   end Get_Bood_Pressure_Degree;
     
   function Compare_To (String1, String2 : String) return Boolean is
   begin
      return String1=String2;
   end Compare_To;
         
   function Delete_Elements (Vector1: Vector; Number: Integer) return Vector is
      Aux_Vector : Vector (0..(Count_Lower_Elements(Vector1, Number)-1)) := (others => 0);
      j : Natural := 0;
   begin
      if Aux_Vector'Length = 0 then
         return (1 => 0);
      end if;
      for i in Vector1'Range loop
         if Vector1(i) <= Number then
            Aux_Vector(j) := Vector1(i);
            j := j + 1;
            if j > Aux_Vector'Last then
               return Aux_Vector;
            end if;
         end if;
         pragma Loop_Invariant (j in Aux_Vector'Range and i in Vector1'Range);
         pragma Loop_Invariant
           (if j /= 0 then
              (for some K in Vector1'First..i => Vector1(K) <= Number)
            else
              (for all K in Vector1'First..i => Vector1(K) > Number));
      end loop;
      return Aux_Vector;
   end Delete_Elements;
                
   function Count_Lower_Elements(Vector1 : Vector; Number: Integer) return Natural is
      i : Natural := Vector1'First;
      Count : Natural := 0;
   begin
      while i<=Vector1'Last loop
         if Vector1(i)<Number then
            Count := Count + 1;
         end if;
         pragma Loop_Variant(Increases => i);
         pragma Loop_Invariant(i in Vector1'First..Vector1'Last);
         pragma Loop_Invariant(Count in 0..i+1);
         pragma Loop_Invariant(Count <= (i-Vector1'First)+1);
         i := i + 1;
      end loop;
      return Count;
   end Count_Lower_Elements;
end P3_1;
