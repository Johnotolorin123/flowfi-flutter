// Environment Variables
class Environment {
  static const String supabaseUrl = String.fromEnvironment(
    'https://coilqovuhmavwbzptrqo.supabase.co',
    defaultValue: '',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNvaWxxb3Z1aG1hdndienB0cnFvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzEwOTI2MDEsImV4cCI6MjA4NjY2ODYwMX0.yUeqDk46K809FrU062sui21kpZ2_TA8Mb6ck7jrsjzI',
    defaultValue: '',
  );
}
