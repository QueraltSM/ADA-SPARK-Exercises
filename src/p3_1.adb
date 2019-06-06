with P3_1; use P3_1;
with Ada.Text_IO; use Ada.Text_IO; 
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; 

package body P3_1 with SPARK_Mode => On is
   
   -- Procedimientos
   
   procedure multiplyVectors (vec1 : Vector; vec2 : Vector) is
      count : Integer := 0;
   begin
      if vec1'Length <= vec2'Length then
         count := vec1'Length;
      else
         count := vec2'Length;
      end if;
      
      for i in 0..count-1 loop   
         Global_Vector(i) := vec1(i)*vec2(i)*Global_Vector(i);
      end loop;
   end multiplyVectors;
   
   
   -- Funciones
   
   function Get_Bood_Pressure_Degree (systolic : Integer; diastolic: Integer) return String is
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
     
   function Compare_To (String1 : String; String2 : String) return Boolean is
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
