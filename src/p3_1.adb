with P3_1; use P3_1;
with Ada.Text_IO; use Ada.Text_IO; 
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; 
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body P3_1 with SPARK_Mode => On is
     
   procedure Search_And_Increment (number: Natural) is
      i : Natural := Global_Vector'First;
   begin
      while (i <= Global_Vector'Last) loop
         pragma Loop_Invariant(I in Global_Vector'Range);
         pragma Loop_Invariant((for all K in I..Global_Vector'Last => Global_Vector(K) /= number)
                               or else (for some K in I..Global_Vector'Last => Global_Vector(K) = number));
         if Global_Vector(i) = number then
            Global_Vector(i) := number + Increment;
         end if;
         i := i + 1;
      end loop;
   end Search_And_Increment;
      
      
   function Inverse_Vector return Vector is
      vec : Vector (0..Global_Inverse_Vector'Length-1) := (others => 0);
      i : Natural := vec'First;
      j : Integer := Global_Inverse_Vector'Last;
   begin
      while (i <= vec'Last and j >= Global_Inverse_Vector'First) loop
         pragma Loop_Invariant(I < Max);
         pragma Loop_Invariant(I in vec'First..vec'Last);
         pragma Loop_Invariant(J in Global_Inverse_Vector'Last..Global_Inverse_Vector'First-1);
         pragma Loop_Invariant(for all K in vec'First..I => 
                                 (for all L in J..Global_Inverse_Vector'First => 
                                    vec(K) = Global_Inverse_Vector(L)));
         vec(i) := Global_Inverse_Vector(j);
         i := i + 1;
         j := j - 1;
      end loop;
      return vec;
   end Inverse_Vector;
      

   
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
