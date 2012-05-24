/**
 * history.vala
 * 
 * @author Daniel Kur <Daniel.M.Kur@gmail.com>
 * @see COPYING
 */
 
public class Feedler.HistoryItem : GLib.Object
{
	public string channel {get; private set;}
	public string item {get; private set;}
	
	public HistoryItem (string channel, string item)
	{
		this.channel = channel;
		this.item = item;
	}
}

public class Feedler.History : GLib.Object
{
	public Gee.LinkedList<Feedler.HistoryItem> items {get; private set;}
	public int current {get; private set;}
	
	construct
	{
		this.items = new Gee.LinkedList<Feedler.HistoryItem> ();
		this.current = -1;
	}
	
	public void add (string channel, string item)
	{
	if (items.size == 0 || (items[current].channel != channel || items[current].item != item))
	{
stderr.printf ("Add\t");
		if (current < items.size - 1)
		{
stderr.printf ("Extend\t");
			this.items = (Gee.LinkedList<Feedler.HistoryItem>)this.items.slice (0, current + 1);
			this.items.add (new Feedler.HistoryItem (channel, item));
			this.current = items.size - 1;
stderr.printf ("OK: %i ?? %i\n", items.size, current);
		}
		else
		{
stderr.printf ("Simple\t");
			this.items.add (new Feedler.HistoryItem (channel, item));
			this.current++;
stderr.printf ("OK: %i ?? %i\n", items.size, current);
		}
	}
	}
	
	public void next (out string side_path, out string? view_path)
	{
		this.current++;
		side_path = items[current].channel;
		view_path = items[current].item;
	}

	public void prev (out string side_path, out string? view_path)
	{
		this.current--;
		side_path = items[current].channel;
		view_path = items[current].item;
	}
}