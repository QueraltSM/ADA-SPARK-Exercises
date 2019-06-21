with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package P3_1 with SPARK_Mode => ON is
   Max : constant := 1000;
   type Vector is array(Natural range <>) of Integer;

   Global_Vector :  Vector := (-1,-1,-1,-1,-1);
   Global_Inverse_Vector :  Vector := (-3, 5, 9, 0, 22);
   Increment : Integer := 1;

   procedure Search_And_Increment (number: Natural) with
     Global => (In_Out => Global_Vector,
                Input => Increment),
     Depends => (Global_Vector =>+ (number, Increment)),
     Pre => (Global_Vector'Length < Max and Global_Vector'First = 0)
     and ((number >= 0 and then Increment <= Integer'Last - number)
          or else (number < 0 and then Increment >= Integer'First - number)),
     Post => (for all K in Global_Vector'Range =>
                (if number = Global_Vector(K) then Global_Vector(K) = number + Increment));


   function Inverse_Vector return Vector with
     Global => Global_Inverse_Vector,
     Depends => (Inverse_Vector'Result => Global_Inverse_Vector),
     Pre => (Global_Inverse_Vector'Length > 0 and Global_Inverse_Vector'Length < Max) and then
     Global_Inverse_Vector'First=0,
     Post => (for all I in Inverse_Vector'Result'Range =>
                (for all J in reverse Global_Inverse_Vector'Range =>
                     Inverse_Vector'Result(I) = Global_Inverse_Vector(J)));



   function Get_Max_Count(vec1, vec2: Vector) return Integer
     with Global => null,
     Depends => (Get_Max_Count'Result => (vec1, vec2)),
     Pre => (vec1'Length > 0 and vec2'Length > 0) and then (vec1'Length < Max and vec2'Length < Max),
     Post => (if vec1'Length < vec2'Length then Get_Max_Count'Result = vec1'Length);

   function Get_Bood_Pressure_Degree(systolic, diastolic: Integer) return String
     with Global => null,
     Depends => (Get_Bood_Pressure_Degree'Result => (systolic, diastolic)),
     Pre => systolic > 0 and systolic < Integer'Last and diastolic > 0 and diastolic < Integer'Last,
     Post => (if systolic < 80 or diastolic < 60 then
                Get_Bood_Pressure_Degree'Result = "Hypotension" or
                  (if systolic > 80 and systolic < 120 and diastolic > 60 and diastolic < 80 then
                       Get_Bood_Pressure_Degree'Result = "Normal" or
                     (if (systolic > 120 and systolic < 139) or (diastolic > 80 and diastolic < 89) then
                          Get_Bood_Pressure_Degree'Result = "Prehypertension" or
                        (if (systolic > 140 and systolic < 159) or (diastolic > 90 and diastolic < 99) then
                             Get_Bood_Pressure_Degree'Result = "Hypertension grade 1" or
                           (if systolic > 160 or diastolic > 100 then
                                Get_Bood_Pressure_Degree'Result = "Hypertension grade 2" or
                              (if systolic > 180 or diastolic > 110 then
                                   Get_Bood_Pressure_Degree'Result =  "Hypertensive crisis (medical emergency)"
                                     else Get_Bood_Pressure_Degree'Result = "Error"))))));

   function Compare_To (String1, String2: String) return Boolean
     with Global => null,
     Depends => (Compare_To'Result => (String1,String2)),
     Post => Compare_To'Result = (String1 = String2);

   function Delete_Elements (Vector1: Vector; Number: Integer) return Vector
     with Global => null,
     Depends => (Delete_Elements'Result => (Vector1, Number)),
     Pre => Vector1'Length < Max and then Vector1'First = 0,
     Post => (if Delete_Elements'Result'Length = 0 then
                (for all K in Vector1'Range => Vector1(K) > Number)) or
     (if Delete_Elements'Result'Length > 0 then
        (for some K in Vector1'Range => Vector1(K) <= Number));

   function Count_Lower_Elements(Vector1 : Vector; Number: Integer) return Natural
     with Global => null,
     Depends => (Count_Lower_Elements'Result => (Vector1, Number)),
     Pre => Vector1'Length < Max and then Vector1'First = 0,
     Post => (if Vector1'Length = 0 then Count_Lower_Elements'Result = 0) or
     (if Count_Lower_Elements'Result /= 0 then
        (for some K in Vector1'Range => Vector1(K)<Number)
          else
        (for all X in Vector1'Range => Vector1(X)>=Number));

end P3_1;
