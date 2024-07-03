public static class SwitchTest
{
    private static string GenericFirstCharProcessing(
        this string input,
        Func<string, string> firstCharProcessor
    ) =>
        input switch
        {
            null => throw new ArgumentNullException(nameof(input)),
            "" => throw new ArgumentException($"{nameof(input)} cannot be empty", nameof(input)),
            _ => firstCharProcessor(input[0].ToString()) + input.Substring(1)
        };

    private static void T()
    {
        var defaultInt = default(int);

        try { }
        catch (Exception e) when (true) { }
        finally { }

        using (var stream = new Stream()) { }

        lock (new string()) { }

        var name = "test";
        switch (name)
        {
            case "aab":
            {
                break;
            }
            case var o when (o?.Trim().Length ?? 0) == 0:
            case "test":
                break;
            default:
                break;
        }

        int c = (int)b; // explicit conversion from long to int

        Type[] t = { typeof(int), };
        sizeof(int);
        int AllBits = unchecked((int)0xFFFFFFFF);
        int AllBits = checked((int)0xFFFFFFFF);
        Span<long> span5 = stackalloc[] { 11, 12, 13 };
    }

    enum Color
    {
        Red,
        Blue,
        Green
    }
}
