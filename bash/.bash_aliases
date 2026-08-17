# Sourced by ~/.bashrc. Keep personal aliases here so .bashrc stays close to the
# Ubuntu default and stays diffable against it.

# QGIS misrenders under Wayland; force the X11 Qt platform plugin.
alias qgis='QT_QPA_PLATFORM=xcb qgis'

# RunPod datacenters that currently have a 5090 or 4090 in stock.
alias runpod-gpus='runpodctl dc list | jq '"'"'[.[] | select(.gpuAvailability != null) | {id: .id,
  location: .location, gpus: [.gpuAvailability[] | select(.displayName | test("5090|4090"; "i")) | {gpu:
  .displayName, stock: .stockStatus}]} | select(.gpus | length > 0)]'"'"''
