public class TestClass
{
    public string? Name { get; set; }
    public int[][]? MultiDimArray { get; set; }

    private string MergeLines(IEnumerable<IEnumerable<string>> sections)
    {
        return string.Join(",", sections.SelectMany(t => t));
    }

    private void LoopTest()
    {
        foreach (var item in new string[0]) { }

        for (int i = 0; i < 0; i++) { }

        while (false) { }

        do { } while (false);
    }

    private void Interpolation()
    {
        var passTitle = "123";
        if (true) {
        	System.Console.WriteLine($"== {passTitle} ==");
        }
    }

    private void AnonymousObject()
    {
        var a = new { Test = 123, };
    }

    private (int a, float b, (int c, float d)) TupleExpressions()
    {
        return (1, 2, (3, 4));
    }

    private (int, int) GetTupleValue()
    {
        return (1, 2);
    }

    private void TestConsumeTuple()
    {
        var (a, b) = GetTupleValue();
    }
}
