package P3_1 with SPARK_Mode => ON is
   Max : constant := 1000;
   type Vector is array(Natural range <>) of Integer;
   type Character_Vector is array(Natural range <>) of Character;

   GlobalVector : Vector := (1,2,3,-1,-2,-3);

   procedure multiply_global_vector (vector1: Vector)
     with Global => GlobalVector;

   function Get_Bood_Pressure_Degree(systolic : Integer; diastolic: Integer) return String
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

   function Get_Lower_and_Higher(Vector1: Vector) return Vector
     with Global => null,
     Depends => (Get_Lower_and_Higher'Result => (Vector1)),
     Pre => (Vector1'Length > 0 and Vector1'Length < Max) and then Vector1'First = 0,
     Post => (for all K in 1..Vector1'Last =>
                (if Vector1(K) < Get_Lower_and_Higher'Result(0) then
                     Get_Lower_and_Higher'Result(0) = Vector1(K)) or
                  (if Vector1(K) > Get_Lower_and_Higher'Result(1) then
                         Get_Lower_and_Higher'Result(1) = Vector1(K)));

   function Compare_To
     (String1: String;
      String2: String) return Boolean
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
