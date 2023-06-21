internal class TestAttribute : Attribute { }

[Test()]
public class Person
{
    [Test()]
    public string? Name { get; set; }
}
