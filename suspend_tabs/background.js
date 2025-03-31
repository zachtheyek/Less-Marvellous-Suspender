chrome.action.onClicked.addListener(async () => {
  try {
    // Get the active tab in the current window
    const [activeTab] = await chrome.tabs.query({ active: true, currentWindow: true });
    const allTabs = await chrome.tabs.query({ currentWindow: true });

    console.log("Active Tab:", activeTab);
    console.log("All Tabs:", allTabs);

    for (const tab of allTabs) {
      if (tab.id !== activeTab.id && tab.discarded === false && !tab.url.startsWith("chrome://")) {
        try {
          console.log(`Attempting to discard: ${tab.id} (${tab.url})`);
          await chrome.tabs.discard(tab.id);  // Correct discard method
          console.log(`Successfully discarded tab: ${tab.id}`);
        } catch (error) {
          console.warn(`Failed to discard tab ${tab.id}:`, error);
        }
      } else {
        console.log(`Skipping tab: ${tab.id} (${tab.url}) - Already discarded or restricted.`);
      }
    }
  } catch (error) {
    console.error("Error processing tabs:", error);
  }
});
