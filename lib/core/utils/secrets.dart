import 'package:flutter_dotenv/flutter_dotenv.dart';

class Secrets {
  static String supabaseUrl = dotenv.get("SUPABASE_URL");
  static String supabaseKey = dotenv.get("SUPABASE_KEY");

  static String pocketbaseUrl = dotenv.get("POCKETBASE_URL");
  static String pocketbaseFileUrl = dotenv.get("POCKETBASE_FILE_URL");

  static String stripePublishKey = dotenv.get("STRIPE_PUBLISH_KEY");
  static String stripeSecretKey = dotenv.get("STRIPE_SECRET_KEY");
}
